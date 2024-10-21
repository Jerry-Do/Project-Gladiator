extends CharacterBody2D
class_name Interactalbe


@onready var label : Label = %Label
var interacted : bool = false
	
func Interaction():
	%InteractArea.queue_free()
	label.queue_free()
	pass	
