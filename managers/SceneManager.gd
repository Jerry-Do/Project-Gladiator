extends Node


func LoadScene(path : String, scene_to_remove : Node2D):
	
	get_tree().change_scene_to_file(path)
