
extends Biochemical
@export var amount = 0

var fullset = false


func _ready():
	super()
	duplicate_flag = true
	price = 5
	effect_base_amount = amount
	item_name = "ArmEnhancement"
	name = item_name
	display_name = "Arm Enhancement"
	item_description = "Increase fire rate"
	evolve_condition_text = "Collect all three enchantments to have Endurance. Endurance: reduce damage by flat amount and decrease the time of status effects"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob(): 
	player.stats.SetBaseDamageMod((player.stats.ReturnBaseDamageMod() * ((EffectAmount())/100)))



func EvolveCheck():
	if player.get_node("Item").find_child("LegEnhancement", false, false) != null && player.get_node("Item").find_child("ChestEnhancement", false, false) != null:
		player.get_node("Item").get_node("ChestEnhancement").fullset = true
		player.get_node("Item").get_node("LegEnhancement").fullset = true
		get_parent().item_sets["bioenhancement"]
		fullset = true
