extends EnvironmentProps
class_name Interactable

@onready var game_manager : GameManager = get_tree().get_first_node_in_group("GameManager")
@onready var label : Label = %Label
var interacted : bool = false
	
func Interaction():
	interacted = true
	%InteractArea.queue_free()
	pass	
