
extends Tech
@export var amount = 0
@export var missing_health = 0
var player_flag = false
var current_health
var base_damage
var fullset

func _ready():
	super()
	duplicate_flag = false
	price = 46
	item_name = "BerserkerArmguard"
	display_name = "Berserker Armguard"
	item_description = "Increase the player's damage based on missing health ("+ str(missing_health)+"% Missing health = "+ str(amount) +"% Damage Mod)"
	evolve_condition_text = "Collect three pieces of the berserker set to get set bonus. Set bonus Rage: reduce the player's max health by half, and increase the effectiveness of the items"
	if get_parent() == player.get_node("Item"):
		player.stats.connect("health_change",  self.HealthChange)
		EvolveCheck()
		HealthChange()	
	return null



func HealthChange():
	var percentage_health  = float(player.stats.ReturnHealth())/ float(player.stats.maxHealth)
	var amount = ((1 - percentage_health) * 100) / (missing_health if fullset == false else 1)
	player.stats.SetDamageMod(amount)
	
func EvolveCheck():
	if player.get_node("Item").find_child("BerserkerChestplate", false, false) != null:
		fullset = true
		player.get_node("Item").get_node("BerserkerChestplate").fullset = true
		player.stats.maxHealthAllowed /= 2
		if player.stats.ReturnHealth() > player.stats.maxHealthAllowed:
			player.stats.SetHealth(-(player.stats.ReturnHealth() / 2))
