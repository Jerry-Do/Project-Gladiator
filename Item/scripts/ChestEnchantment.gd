
extends Biochemical
@export var amount = 0
var fullset = false


func _ready():
	super()
	duplicate_flag = true
	price = 20
	effect_base_amount = amount
	item_name = "ChestEnhancement"
	display_name = "Chest Enchance"
	name = item_name
	item_description = "Increase base armor mod by " + str(EffectAmount()) + " %"
	evolve_condition_text = "Collect all three enchantments to have Endurance. Endurance: reduce damage by flat amount and decrease the time of status effects"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob(): 
	player.stats.SetBaseDamageMod((player.stats.ReturnBaseDamageMod() * ((EffectAmount())/100)))

func UpdateDescription():
	item_description = "Increase the output damage by " + str(EffectAmount()) + " %"

func EvolveCheck():
	if player.get_node("Item").find_child("ArmEnhancement", false, false) != null && player.get_node("Item").find_child("LegEnhancement", false, false) != null:
		player.get_node("Item").get_node("ArmEnhancement").fullset = true
		player.get_node("Item").get_node("LegEnhancement").fullset = true
		fullset = true
