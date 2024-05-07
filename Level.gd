#Game Manager: handles UI and game logics
extends Node2D

@onready var ui = get_node("/root/Game/Level/UI")
@export var weapons : Array
@export var maxKillCount : int
@export var fameMultiTimeFrame : float 

var rng = RandomNumberGenerator.new()
var maxFame: int = 5
var currentFame: int
var fameMultiplier: float = 1.0
var killCount : int = 0
var increaseMulti : bool 
func UpdateHealth(value):
	ui.update_health_text(value)

func UpdateAmmo(value):
	ui.update_ammo_text(value)

func _process(delta):
	ui.update_fame_text(currentFame, maxFame)
	ui.update_fameMulti_text(fameMultiplier)
	if %FameMultiplierTimer:
		ui.update_fameMultiTimer_text(%FameMultiplierTimer.get_time_left())

func SpawnWeapon():
	var player = get_node("/root/Game/Level/Player")
	var randomNo = rng.randi_range(0, weapons.size() - 1)
	var weapon = load(weapons[randomNo])
	var newWeapon = weapon.instantiate()
	newWeapon.position = Vector2(player.global_position.x + 1, player.global_position.y)
	newWeapon.rotation = player.rotation
	add_child(newWeapon)

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

#Start the timer
#On kill stop and reset the timer
#if timer reaches zero reset kill count
#
#
#
#
#
