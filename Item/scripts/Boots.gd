
extends Item
@export var amount = 0



func _ready():
	item_name = "Boots"
	item_description = "Increase the player movement speed"
	if get_parent() == player.get_child(6):
		DoJob()
	return null

func DoJob():
	player.stats.SetSpeed(player.stats.ReturnSpeed() + (player.stats.ReturnSpeed() * (amount * 2)/100)) 

func Duplicate():
	_set_quantity(1)
	DoJob()
