
extends Item
@export var amount = 0
@onready var player = get_tree().get_first_node_in_group("player")


func _ready():
	item_name = "Shield"
	item_description = "Gives the player a shield"
	if get_parent() == player.get_child(6):
		player.shield_amount = amount
	return null

	
