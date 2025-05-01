extends DestructableProps

var is_on_fire : bool = false

	

	


func _on_area_entered(area):
	if area.has_method("SetStatus"):
		area.SetStatus("bleed", 3)
		queue_free()
