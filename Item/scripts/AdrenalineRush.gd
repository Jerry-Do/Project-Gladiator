
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
func _ready():
	super()
	duplicate_flag = false
	price = 60
	effect_base_amount = amount
	item_name = "AdrenalineRush"
	name = item_name
	display_name = "Adrenaline Rush"
	item_description = "Increase movement speed by " + str(amount) + " % on enemy killed for" + str(duration) + ". Also grants " \
	+ str(dmg_amount) + " damage bonus"
	return null

func DoJob(): 	
	if in_state == false:
		in_state = true
		if evolve_flag == false:		
			enemy_killed += 1
			if enemy_killed >= evo_amount:
				evolve_flag = true
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
