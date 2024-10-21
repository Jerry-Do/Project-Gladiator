
extends Item
@export var amount = 0



func _ready():
	item_name = "Boots"
	display_name = "Boots"
	item_description = "Increase the player movement speed by " + str(amount) + " %"
	if get_parent() == player.get_child(6):
		DoJob()
	return null

func DoJob(): 
	player.stats.SetSpeed(player.stats.ReturnSpeed() * (1 + ((amount * quantity)/100)))
	
