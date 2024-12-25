
extends Biochemical
@export var amount = 0
@export var evolve_amount = 0
@export var distance_to_evo = 0 

var distance_traveled : float
var evolved_flag = false
var original_speed : float
var fullset = false

func _ready():
	super()
	duplicate_flag = true
	price = 8
	effect_base_amount = amount
	item_name = "Leg Enhancement"
	display_name = "Leg Enhancement"
	item_description = "Increase the player movement speed by " + str(EffectAmount()) + " %"
	evolve_condition_text = "Collect all three enchantments to have Endurance. Endurance: reduce damage by flat amount and decrease the time of status effects"
	if get_parent() == player.get_node("Item"):
		original_speed = player.stats.ReturnSpeed()
		DoJob()
		player.get_node("StateControl/Move").connect("GetDistance", EvolveCheck)	
	return null

func DoJob(): 
	player.stats.SetSpeed(original_speed * (1 + ((amount * quantity)/100.0)))
	
	
func EvolveCheck(amount):
	if player.get_node("Item").find_child("ArmEnhancement", false, false) != null && player.get_node("Item").find_child("ChestEnhancement", false, false) != null:
		player.get_node("Item").get_node("ArmEnhancement").fullset = true
		player.get_node("Item").get_node("ChestEnhancement").fullset = true
		fullset = true


func UpdateDescription():
	item_description = "Increase the player movement speed by " + str(EffectAmount()) + " %, increase to " + str(amount * evolve_amount) + " % when evolved"
