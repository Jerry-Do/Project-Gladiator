extends Node2D


func _on_button_pressed():
	SceneManager.LoadScene("res://scenes/SkillPickerScene.tscn",self)
