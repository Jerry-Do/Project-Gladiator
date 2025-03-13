extends Area2D
class_name EnvironmentProps

func _exit_tree():
	get_parent().spawned_props.erase(self)
