
extends Item
@export var amount = 1
@onready var player = get_tree().get_first_node_in_group("player")


func _ready():
	item_name = "Health Kit"
	item_description = "Player regenerates health slowly overtime"
	return null

	


func _on_timer_timeout():
	if get_parent() == player.get_child(6):
		player.stats.SetHealth(amount)
