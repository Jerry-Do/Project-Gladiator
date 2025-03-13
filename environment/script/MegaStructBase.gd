extends Interactable
class_name MegaStruct

# Called when the node enters the scene tree for the first time.
func _exit_tree():
	get_parent().environment_spawner.mega_struct = null
