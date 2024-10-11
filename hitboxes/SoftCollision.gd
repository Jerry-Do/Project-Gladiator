extends Area2D

func IsColliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0 

func GetPushVector():
	var areas = get_overlapping_areas()
	var pushVector = Vector2.ZERO
	if IsColliding():
		var area = areas[0]
		var random_dir_change = -1 if randf() < 0.5 else 1 
		pushVector = area.global_position.direction_to(global_position).rotated(random_dir_change * PI/4)
		pushVector = pushVector.normalized()
	return pushVector
	
