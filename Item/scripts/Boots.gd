
extends Item
@export var amount = 0
@export var evolve_amount = 0
@export var distance_to_evo = 0 

var distance_traveled : float
var evolved_flag = false
var original_speed : float

func _ready():
	duplicate_flag = true
	item_name = "Boots"
	display_name = "Boots"
	item_description = "Increase the player movement speed by " + str(amount) + " %, increase to " + str(amount * evolve_amount) + " % when evolved"
	evolve_condition_text = "Move until evolution"
	if get_parent() == player.get_node("Item"):
		original_speed = player.stats.ReturnSpeed()

		DoJob()
		player.get_node("StateControl/Move").connect("GetDistance", EvolveCheck)	
	return null

func DoJob(): 
	player.stats.SetSpeed(original_speed * (1 + ((amount * quantity)/100.0)))
	
	
func EvolveCheck(amount):
	distance_traveled += amount
	if distance_traveled > distance_to_evo && evolved_flag == false:
		amount *= evolve_amount
		player.stats.SetSpeed(original_speed * (1 + ((amount * quantity)/100.0)))
		evolved_flag = true

	
