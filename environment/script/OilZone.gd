extends Area2D

var is_on_fire : bool = false
func _on_area_entered(area):
	if is_on_fire == false:
		if area.has_method("SetStatusOther"):
			area.SetStatusOther("slow",3)
		if area.has_method("SetStatusPlayer"):
			area.SetStatusPlayer("slow",3)
		if (area.has_method("SetStatusOther") || area.has_method("SetStatusPlayer")) && area.get_parent().status_dictionary["fire"] == true:
			is_on_fire = true
			%Oil.self_modulate = Color.RED
	if is_on_fire == true:
		if area.has_method("SetStatusOther"):
			area.SetStatusOther("fire",3)
		if area.has_method("SetStatusPlayer"):
			area.SetStatusPlayer("fire",3)
