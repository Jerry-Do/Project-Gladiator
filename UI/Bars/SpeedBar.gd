extends ProgressBar


var speed = 0 : set = _set_speed

func _set_speed(new_speed):
	var _prev_speed = speed
	speed = min(max_value,new_speed)
	value = new_speed
	

func init_speed(_speed):
	speed = _speed
	max_value = max_value
	value = speed
