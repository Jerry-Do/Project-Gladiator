extends Tech
@export var cooldown : float = 0
@export var damage : float = 0
func _ready():
	super()
	duplicate_flag = false
	price = 40
	item_name = "HomingMissle"
	display_name = "Homing Missle"
	name = item_name
	item_description = "Shoots homing missles after " + str(cooldown) + " seconds, dealing " + str(damage) + " damage, and explodes on hit. Number of missles equals with the number of tech items, capped at 5"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob():
	$Timer.start(cooldown)


func _on_timer_timeout():
	for i in clamp(player.get_node("Item").item_types.tech, player.get_node("Item").item_types.tech, 5):
		var missle = preload("res://Item/etc/HMissle.tscn")
		var real = missle.instantiate()
		real.damage = damage
		real.global_position = self.global_position
		real.rotation = self.rotation
		player.get_parent().add_child(real)
