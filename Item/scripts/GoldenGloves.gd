
extends Item
@export var amount = 0
@onready var player = get_tree().get_first_node_in_group("player")


func _ready():
	item_name = "Golden Gloves"
	item_description = "Bullets now can crit"
	if get_parent() == player.get_child(6):
		player.can_crit = true
	return null

	
