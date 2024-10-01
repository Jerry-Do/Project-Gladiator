#Game Manager: handles UI and game logics
extends Node2D

@onready var ui = %UI
@onready var enemy_spawner = %Spawner
@onready var weaponSpawnPoints = %WeaponSpawnPoints
@export var duplication_array : Array
@export var weapons : Array
@export var maxKillCount : int
@export var fameMultiTimeFrame : float 
var pick_up_weapon = false
var timeSlowFlag : bool = false
var rng = RandomNumberGenerator.new()
var maxFame: int = 1
var currentFame: int
var fameMultiplier: float = 1.0
var killCount : int = 0
var increaseMulti : bool 
var newWeapon
var oldWeapon
var currentWave = 1
	
func UpdateAmmo(value):
	ui.update_ammo_text(value)

func UpdateItemSprite(spritePath):
	ui.update_item_sprite(spritePath)

func _process(_delta):
	if %FameMultiplierTimer.is_stopped() == false:
		ui.update_fameMultiTimer_text(%FameMultiplierTimer.get_time_left())
	if %WeaponTimer.is_stopped() == false:
		ui.update_WeaponTimer_text(%WeaponTimer.get_time_left())
		ui.set_new_weapon_alert_visibility(true)
		ui.set_new_weapon_timer_alert_visibility(true)
		await get_tree().create_timer(%WeaponTimer.get_time_left()).timeout
		ui.set_new_weapon_alert_visibility(false)
		ui.set_new_weapon_timer_alert_visibility(false)
	
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
	get_parent().add_child(newWeapon)
	%WeaponTimer.start()

func AdjustFame(value):
	currentFame += value * fameMultiplier
	if currentFame == maxFame:
		SpawnWeapon()
		maxFame *= 2
	ui.update_fame_text(currentFame, maxFame)
	

func AdjustFameMultiplier(value):
	fameMultiplier += value
	ui.update_fameMulti_text(fameMultiplier)
	
func IncreaseKillCount():
	%FameMultiplierTimer.start(fameMultiTimeFrame)
	killCount += 1
	if killCount == maxKillCount:
		killCount = 0
		AdjustFameMultiplier(0.1)

func WaveComplete():
	ui.set_wave_finisher_alert_visibility(true, currentWave)
	var upgrade_scene = preload("res://UI/UpgradeScene.tscn")
	var upgrade_scene_instantiate = upgrade_scene.instantiate()
	ui.add_child(upgrade_scene_instantiate)
	get_tree().paused = true
	currentWave+=1

func _on_fame_multiplier_timer_timeout():
	%FameMultiplierTimer.stop()
	killCount = 0

func _on_weapon_timer_timeout():
	if pick_up_weapon == false:
		%WeaponTimer.stop()
		print(newWeapon.get_parent())
		get_parent().remove_child(newWeapon)
	pick_up_weapon = true

func UpgradeChose(node_path):
	ui.remove_child(ui.get_child(1))
	var player = get_node("../Player")
	var item = load(node_path)
	var new_item = item.instantiate()
	player.get_child(6).add_child(new_item)
	duplication_array.append(new_item.ReturnName())
	new_item.item_sprite.hide()
	StartWave()

func StartWave():
	get_tree().paused = false
	enemy_spawner.maxAllow += 1
	enemy_spawner.spawnCount = 0
	ui.set_wave_finisher_alert_visibility(false, currentWave)
	
