extends Area2D
class_name EnvironmentProps

func _exit_tree():
	if get_parent().name == "EnvironmentSpawner":
		get_parent().spawned_props.erase(self)
