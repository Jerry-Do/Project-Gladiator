extends Node2D

var path : String

func Instantiate(path_m : String):
	path = path_m
	$Timer.start()
	if get_tree().get_first_node_in_group("player").get_node("Item").get_node_or_null("BrainChip") != null:
		show()

func _on_timer_timeout():
	var enemy = load(path) 
	var real = enemy.instantiate()
	real.global_position = global_position
	get_tree().get_first_node_in_group("GameManager").get_parent().add_child(real)
	queue_free()
