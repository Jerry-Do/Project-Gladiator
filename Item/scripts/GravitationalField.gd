extends Tech
@export var slow_duration = 0
@export var no_enemy_slow_to_evo = 0
var no_current_enemy_slow = 0

func _ready():
	super()
	duplicate_flag = false
	price = 15
	item_name = "GravitationalField"
	display_name = "Gravitational Field"
	item_description = "Decrease the movement speed of enemies by 50% in a radius for " \
	+ str(slow_duration) + ", increase to " + str(slow_duration * 2) + " and in a bigger radius"
	evolve_condition_text = "Slow " + str( no_enemy_slow_to_evo) + " enemies at the same time "
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob():
	$Timer.start()

func UpdateDescription():
	item_description = "Decrease the movement speed of enemies by 50% in a radius for " \
	+ str(slow_duration) + ", increase to " + str(slow_duration * 2) + " and in a bigger radius"
	


func _on_area_2d_area_entered(area):
	if area.has_method("SetStatusOther"):
		area.SetStatusOther("slow", slow_duration)
		no_current_enemy_slow+=1
		if no_current_enemy_slow == no_enemy_slow_to_evo && evolve_flag == false:
			evolve_flag = true
			slow_duration *= 2
			$Area2D/CollisionShape2D.shape.radius = 200
			print("Evolved")

func _on_timer_timeout():
	await get_tree().create_timer(0.25).timeout
	$AnimationPlayer.play("emit")
	


func _on_area_2d_area_exited(area):
	if area.has_method("SetStatusOther"):
		no_current_enemy_slow-=1
		
