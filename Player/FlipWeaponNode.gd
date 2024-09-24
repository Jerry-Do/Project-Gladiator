extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_child(0):
		var mouse_pos =  get_local_mouse_position()
	
