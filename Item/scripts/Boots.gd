
extends Item
@export var amount = 0
@onready var player = get_tree().get_first_node_in_group("player")


func _ready():
	item_name = "Boots"
	item_description = "Increase the player movement speed"
	if get_parent() == player.get_child(6):
		player.stats.SetSpeed(player.stats.ReturnSpeed() + amount)
	return null

	
