extends Area2D

var is_on_fire : bool = false
func _on_area_entered(area):
	if is_on_fire == false:
		if area.has_method("SetStatus"):
			area.SetStatus("slow",3)
		if (area.has_method("SetStatus") && area.get_parent().status_dictionary["fire"] == true) \
		|| area.has_method("SetOilOnFire"):
			SetOilOnFire()
	if is_on_fire == true:
		if area.has_method("SetStatus"):
			area.SetStatus("fire",3)


func _on_timer_timeout():
	queue_free()

func SetOilOnFire():
	is_on_fire = true
	%Oil.self_modulate = Color.RED
