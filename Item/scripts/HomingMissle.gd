extends Tech
@export var cooldown : float = 0
@export var damage : float = 0
func _ready():
	super()
	duplicate_flag = false
	price = 40
	item_name = "HomingMissle"
	display_name = "Homing Missle"
	item_description = "Shoots a homing missle after " + str(cooldown) + " seconds, dealing " + str(damage) + " damage, and explodes on hit"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob():
	$Timer.start(cooldown)


func _on_timer_timeout():
	var missle = preload("res://Item/etc/HMissle.tscn")
	var real = missle.instantiate()
	real.damage = damage
	real.global_position = self.global_position
	real.rotation = self.rotation
	player.get_parent().add_child(real)
