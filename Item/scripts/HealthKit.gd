
extends Item
@export var amount = 1
#Evo con: not taking damage for a certain amount of time
#Evo effect: regen even when taking damage


func _ready():
	duplicate_flag = true
	item_name = "HealthKit"
	display_name = "Health Kit"
	item_description = "Player regenerates " + str(amount) + " health slowly overtime, if they are not taking damage"
	return null

func Duplicate():
	_set_quantity(1)


func _on_timer_timeout():
	if get_parent() == player.get_node("Item"):
		player.stats.SetHealth(amount * quantity)
		player.healthBar._set_health(player.stats.ReturnHealth())
