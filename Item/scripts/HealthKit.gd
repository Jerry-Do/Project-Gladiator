
extends Item
@export var amount = 1


func _ready():
	item_name = "HealthKit"
	display_name = "Health Kit"
	item_description = "Player regenerates health slowly overtime"
	return null

	


func _on_timer_timeout():
	if get_parent() == player.get_child(6):
		player.stats.SetHealth(amount)
