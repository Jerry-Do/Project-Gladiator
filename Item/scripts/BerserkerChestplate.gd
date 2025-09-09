
extends Biochemical
@export var amount = 0
@export var missing_health = 0
var player_flag = false
var current_health
var base_damage
var fullset

func _ready():
	super()
	duplicate_flag = false
	price = 60
	effect_base_amount = amount
	item_name = "Endorphine"
	name = item_name
	display_name = "Endorphine"
	item_description = "Increase the player's armor based on missing health"
	evolve_condition_text = "Collect all three chemicals to unlock 'Addict'"
	if get_parent() == player.get_node("Item"):
		player.stats.connect("health_change",  self.HealthChange)
		HealthChange()
		EvolveCheck()
		
	return null



func HealthChange():
	var percentage_health  = float(player.stats.ReturnHealth())/ float(player.stats.maxHealth)
	var amount = ((1 - percentage_health)) / (missing_health if fullset == false else 1)
	var real = player.stats.stats.Base_Armor * amount
	player.stats.SetArmor(real)


func EvolveCheck():
	var ad = player.get_node("Item").find_child("Adrenaline", false, false)
	var do = player.get_node("Item").find_child("Dopamine", false, false)
	if ad == null || do == null:
		return 
	fullset = true
	ad.fullset = true
	do.fullset = true
	player.stats.maxHealthAllowed /= 2
	if player.stats.ReturnHealth() > player.stats.maxHealthAllowed:
		player.stats.SetHealth(-(player.stats.ReturnHealth() / 2))
