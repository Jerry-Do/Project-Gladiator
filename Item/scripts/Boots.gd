
extends Item
@export var amount = 0
@export var evo_amount = 0 

var distance_travel : float

func _ready():
	duplicate_flag = true
	item_name = "Boots"
	display_name = "Boots"
	item_description = "Increase the player movement speed by " + str(amount) + " %"
	if get_parent() == player.get_node("Item"):
		DoJob()
		player.get_node("StateControl/Move").connect("GetDistance", EvolveCheck)

	return null

func DoJob(): 
	player.stats.SetSpeed(player.stats.ReturnSpeed() * (1 + ((amount * quantity)/100)))
	
func EvolveCheck(amount):
	distance_travel += amount
	if distance_travel > evo_amount:
		player.stats.SetSpeed(player.stats.ReturnSpeed() * (1 + ((amount * quantity)/75)))

	print(distance_travel)
