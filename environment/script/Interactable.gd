extends CharacterBody2D
class_name Interactalbe


@onready var label : Label = %Label
var interacted : bool = false
	
func Interaction():
	interacted = true
	%InteractArea.queue_free()
	pass	
