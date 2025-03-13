extends ProgressBar


var fuel = 0 : set = _set_fuel

func _set_fuel(new_fuel):
	var _prev_fuel = fuel
	fuel = min(max_value, new_fuel)
	value = fuel
	

func init_fuel(_fuel):
	fuel = _fuel
	max_value = _fuel
	value = fuel
