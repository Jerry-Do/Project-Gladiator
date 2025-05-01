extends Area2D

var interactable = null

func _input(event):
	if interactable:
		if event.is_action_pressed("interact"):
			interactable.Interaction()

func _on_area_entered(area):
	if area.has_method("Interaction"):
		area.get_parent().label.show()
		interactable = area


func _on_area_exited(area):
	if area.has_method("Interaction"):
		area.get_parent().label.hide()
		interactable = null
