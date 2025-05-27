extends PointLight2D



func _on_area_2d_area_entered(area):
	if area.has_method("Spotlight"):
		area.Spotlight(true)


func _on_area_2d_area_exited(area):
	if area.has_method("Spotlight"):
		area.Spotlight(false)
