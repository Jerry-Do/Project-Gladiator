
extends Item
@export var amount = 0



func _ready():
	item_name = "Boots"
	item_description = "Increase the player movement speed"
	if get_parent() == player.get_child(6):
		DoJob()
	return null

func DoJob(): 
	player.stats.SetChargeTime(-(player.stats.ReturnChargeTime() * ((amount * quantity) / 100)))
