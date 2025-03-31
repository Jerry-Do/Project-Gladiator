extends Tech
@export var cooldown : float = 0
@export var damage : float = 0
@export var item_per_rocket : int = 0
func _ready():
	super()
	duplicate_flag = false
	price = 40
	item_name = "HomingMissle"
	display_name = "Homing Missle"
	name = item_name
	item_description = "Shoots homing missles after " + str(cooldown) + " seconds, dealing " + str(damage) + " damage, and explodes on hit. Number of missles increases based on number of tech items"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob():
	$Timer.start(cooldown)


func _on_timer_timeout():
	for i in roundi(player.get_node("Item").item_types.tech / item_per_rocket):
		var random = -1
		var crit_chance = -2
		var missle = preload("res://Item/etc/HMissle.tscn")
		var real = missle.instantiate()
		if player.get_node("Item").item_critable:
			crit_chance = 100 - player.stats.ReturnCritChance()
			random = RandomNumberGenerator.new().randi_range(1, crit_chance + 1)
		real.damage = damage * (1 if crit_chance != random else 2)
		real.global_position = self.global_position
		real.rotation = self.rotation
		player.get_parent().add_child(real)
