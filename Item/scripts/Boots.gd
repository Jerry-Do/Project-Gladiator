
extends Item
@export var amount = 0



func _ready():
	item_name = "Boots"
	item_description = "Increase the player movement speed"
	if get_parent() == player.get_child(6):
		player.stats.SetSpeed(player.stats.ReturnSpeed() + amount)
	return null

	
