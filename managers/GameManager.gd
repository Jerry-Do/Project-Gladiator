#Game Manager: handles UI and game logics
extends Node2D
class_name GameManager
@onready var ui : UI = %UI
@onready var enemy_spawner = %Spawner
@onready var weaponSpawnPoints = %WeaponSpawnPoints
@onready var round_timer = %RoundTimer
@onready var environment_spawner = %EnvironmentSpawner

@export var duplication_array : Array
@export var weapons : Array
@export var maxKillCount : int
@export var fameMultiTimeFrame : float
@export var maxFame : int = -1

static var instance : GameManager = null
var pick_up_weapon = false
var timeSlowFlag : bool = false
var rng = RandomNumberGenerator.new()
var maxKill: int = 10
var currentKill: int
var fameMultiplier: float = 1.0
var killCount : int = 0
var increaseMulti : bool 
var newWeapon : Weapon
var oldWeapon : Weapon
var currentWave : int = 1
var currentFame : int = 0
var currency : int = 0
var player : Player
var pop_up : bool = false

signal RoundEnd
signal RoundStart

func _ready():
	instance = self
	
func _input(event):	
	if event.is_action_pressed("stats_screen") && pop_up == false:
		if ui.get_node_or_null("InfoScene") != null:
			ui.get_node_or_null("InfoScene").queue_free()
			get_tree().paused = false
		else:
			CreateStatsScreen()
		
func _process(_delta):
	ui.set_timer(round_timer.time_left)
	if %FameMultiplierTimer.is_stopped() == false:
		ui.update_fameMultiTimer_text(%FameMultiplierTimer.get_time_left())
	if %WeaponTimer.is_stopped() == false:
		ui.update_WeaponTimer_text(%WeaponTimer.get_time_left())
		ui.set_new_weapon_alert_visibility(true)
		ui.set_new_weapon_timer_alert_visibility(true)
	else:
		ui.set_new_weapon_alert_visibility(false)
		ui.set_new_weapon_timer_alert_visibility(false)

func UpdateAmmo(value):
	ui.update_ammo_text(value)

func UpdateItemSprite(spritePath):
	ui.update_item_sprite(spritePath)
	
func SpawnWeapon():
	var children = weaponSpawnPoints.get_children()
	var random_pos = rng.randi_range(0, children.size() - 1)
	var random_weapon = rng.randi_range(0, weapons.size() - 1)
	var weapon = load(weapons[random_weapon])
	var spawn_pos = children[random_pos]
	newWeapon = weapon.instantiate()
	newWeapon.position = Vector2(spawn_pos.global_position.x, spawn_pos.global_position.y)
	newWeapon.rotation = spawn_pos.rotation
	newWeapon.scale = spawn_pos.scale
	currentKill = 0
	get_parent().add_child(newWeapon)
	%WeaponTimer.start()

func AdjustKill(value):
	%FameMultiplierTimer.start(fameMultiTimeFrame)
	currentKill += value
	if currentKill == maxKill:
		currentKill = 0
		AdjustFameMultiplier(0.2)
		SpawnWeapon()
	ui.update_kill_text(currentKill, maxKill)
	
func AdjustFame(value):
	currentFame += value * fameMultiplier
	currentFame = clamp(currentFame, 0, currentFame)
	ui.update_fame_text(currentFame)
	
func AdjustFameMultiplier(value):
	fameMultiplier += value
	ui.update_fameMulti_text(fameMultiplier)
	

func WaveComplete():
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.SelfDestruct()
	var upgrade_scene = preload("res://UI/UpgradeScene.tscn")
	var upgrade_scene_instantiate = upgrade_scene.instantiate()
	ui.add_child(upgrade_scene_instantiate)
	environment_spawner.DestroyEnvironment()
	pop_up = true
	get_tree().paused = true
	currentWave+=1
	RoundEnd.emit()

func _on_fame_multiplier_timer_timeout():
	%FameMultiplierTimer.stop()
	killCount = 0

func _on_weapon_timer_timeout():
	if newWeapon.get_parent() == get_parent():
		get_parent().remove_child(newWeapon)
		ui.set_new_weapon_alert_visibility(false)
		ui.set_new_weapon_timer_alert_visibility(false)

func UpgradeChose(scene_path: String, item_name : String, price : int):
	if currency >= price:
		var item = load(scene_path)
		var new_item : Item = item.instantiate()
		if duplication_array.find(item_name) != -1:
			player.get_node("Item").get_node(item_name).Duplicate()
			DestroyUpgradeSceneAndStartNewWave()
			return null
		player.get_node("Item").add_child(new_item)
		duplication_array.append(new_item.ReturnName())
		player.get_node("Item").IncreaseType(new_item.ReturnFaction())
		new_item.item_sprite.hide()
		AdjustCurrency(-price)
		DestroyUpgradeSceneAndStartNewWave()


func StartWave():
	get_tree().paused = false
	enemy_spawner.maxAllow += 1
	#enemy_spawner.spawnCount = 0
	environment_spawner.SpawnEnvironemnt()
	#ui.set_wave_finisher_alert_visibility(false, currentWave)
	RoundStart.emit()

func DestroyUpgradeSceneAndStartNewWave():
	ui.remove_child(ui.get_node("UpgradeScreen"))
	pop_up = false
	StartWave()
	
func CreateWeaponDescription(weapon : Weapon):
	var description = preload("res://UI/GunDescription.tscn")
	var real_description = description.instantiate()
	real_description.SetUp(weapon.ReturnName(), weapon.ReturnDescription())
	ui.get_node("Control").add_child(real_description)

func GameOver():
	#get_tree().get_first_node_in_group("player").queue_free()
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.SelfDestruct()
	await get_tree().create_timer(0.1).timeout
	SceneManager.LoadScene("res://scenes/GameOver.tscn", self)


func _on_round_timer_timeout():
	if currentFame < maxFame:
		GameOver()
	else:
		WaveComplete()
		

func AdjustCurrency(value):
	currency += value
	currency = clamp(currency, 0, currency)
	ui.update_currency_text(currency)
		
func LevelUpPlayer():
	if currency >= (player.stats.stats.Level * 10):
		AdjustCurrency(-player.stats.stats.Level * 10)
		player.LevelUp()
		DestroyUpgradeSceneAndStartNewWave()

func CreateStatsScreen():
	var stats_scene = preload("res://UI/InfoScreen.tscn")
	var stats_scene_instantiate = stats_scene.instantiate()
	ui.add_child(stats_scene_instantiate)
	get_tree().paused = true
