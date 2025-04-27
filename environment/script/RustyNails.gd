extends DestructableProps

var is_on_fire : bool = false

	

	


func _on_area_entered(area):
	area.SetStatus("bleed", 3)
	queue_free()
