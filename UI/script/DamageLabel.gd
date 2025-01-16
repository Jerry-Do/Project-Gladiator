extends Control


func _physics_process(delta):
	position = Vector2(position.x, position.y - 1)

func _on_timer_timeout():
	queue_free()
