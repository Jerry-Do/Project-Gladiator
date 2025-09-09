
extends Biochemical
@export var amount = 0
@export var evo_amount = 0
@export var duration = 0
@export var dmg_amount = 0
var enemy_killed = 0
var in_state : bool = false
var og_speed : float = 0
var cal_dmg_mod : float = 0
var dmg_buffed : bool = false
var fullset : bool = false
func _ready():
	super()
	duplicate_flag = false
	price = 55
	effect_base_amount = amount
	item_name = "Dopamine"
	name = item_name
	display_name = "Dopamine"
	item_description = "Increase movement speed on kill and bonus damage when evolved"
	if get_parent() == player.get_node("Item"):
		EvolveCheck()
	return null

func DoJob(): 	
	if in_state == false:
		in_state = true
		if evolve_flag && dmg_buffed == false:
			player.stats.SetDamageMod(cal_dmg_mod)
			cal_dmg_mod = player.stats.ReturnBaseDamageMod() * ((dmg_amount)/100)
			dmg_buffed = true
		og_speed = player.stats.ReturnSpeed()	
		player.stats.SetSpeed(player.stats.ReturnSpeed() + player.stats.ReturnSpeed() * (amount/100.00))
		$Timer.start(duration)
	else:
		$Timer.start(duration)

func _on_timer_timeout():
	if evolve_flag && dmg_buffed == true:
		player.stats.SetDamageMod(-cal_dmg_mod)
		dmg_buffed = false
	player.stats.SetSpeed(og_speed)
	enemy_killed = 0

func EvolveCheck():
	var en = player.get_node("Item").find_child("Endorphine", false, false)
	var ad = player.get_node("Item").find_child("Adrenaline", false, false)
	if en == null || ad == null:
		return 
	evolve_flag = true
	en.fullset = true
	ad.fullset = true
	player.stats.maxHealthAllowed /= 2
	if player.stats.ReturnHealth() > player.stats.maxHealthAllowed:
		player.stats.SetHealth(-(player.stats.ReturnHealth() / 2))
