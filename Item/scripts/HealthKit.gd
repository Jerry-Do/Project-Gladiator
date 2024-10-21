
extends Item
@export var amount = 1


func _ready():
	item_name = "HealthKit"
	display_name = "Health Kit"
	item_description = "Player regenerates " + str(amount) + " health slowly overtime, if they are not moving"
	return null

func Duplicate():
	_set_quantity(1)


func _on_timer_timeout():
	if get_parent() == player.get_child(6) && player.velocity != 0:
		player.stats.SetHealth(amount * quantity)
