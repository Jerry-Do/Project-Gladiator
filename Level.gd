#Game Manager: handles UI and game logics
extends Node2D

@onready var ui = get_node("/root/Game/Level/UI")
@export var weapons : Array
@export var maxKillCount : int
@export var fameMultiTimeFrame : float 

var rng = RandomNumberGenerator.new()
var maxFame: int = 10
var currentFame: int
var fameMultiplier: float = 1.0
var killCount : int = 0
var increaseMulti : bool 
var newWeapon
var oldWeapon
func UpdateHealth(value):
	ui.update_health_text(value)

func UpdateAmmo(value):
	ui.update_ammo_text(value)

func UpdateItemSprite(spritePath):
	ui.update_item_sprite(spritePath)

func _process(delta):
	ui.update_fame_text(currentFame, maxFame)
	ui.update_fameMulti_text(fameMultiplier)

	if %FameMultiplierTimer:
		ui.update_fameMultiTimer_text(%FameMultiplierTimer.get_time_left())
	if %WeaponTimer:
		ui.update_WeaponTimer_text(%WeaponTimer.get_time_left())
	
func SpawnWeapon():
	var player = get_node("/root/Game/Level/Player")
	var randomNo = rng.randi_range(0, weapons.size() - 1)
	var weapon = load(weapons[randomNo])
	newWeapon = weapon.instantiate()
	newWeapon.position = Vector2(player.global_position.x + 100, player.global_position.y + 100)
	newWeapon.rotation = player.rotation
	var oldWeapon = newWeapon
	if oldWeapon:
		remove_child(oldWeapon)
	add_child(newWeapon)
	$WeaponTimer.start()

func AdjustFame(value):
	currentFame += value * fameMultiplier
	if currentFame == maxFame:
		SpawnWeapon()
		maxFame *= 2
	

func AdjustFameMultiplier(value):
	fameMultiplier += value

func IncreaseKillCount():
	%FameMultiplierTimer.start(fameMultiTimeFrame)
	killCount += 1
	if killCount == maxKillCount:
		killCount = 0
		AdjustFameMultiplier(0.1)


func _on_fame_multiplier_timer_timeout():
	%FameMultiplierTimer.stop()
	killCount = 0




func _on_weapon_timer_timeout():
	$WeaponTimer.stop()
	remove_child(newWeapon)
