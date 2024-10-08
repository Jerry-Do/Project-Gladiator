extends Node


func get_movement_direction() -> Vector2:
	if get_parent().status_dictionary.Stun == true:
		return Vector2(0,0)
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")
