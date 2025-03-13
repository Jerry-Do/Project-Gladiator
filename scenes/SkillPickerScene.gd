extends Node2D


func _on_time_slow_pressed():
	SkillPicker.chosen_skill = "TimeSlowSkill"
	SceneManager.LoadScene("res://scenes/Scene.tscn", self)


func _on_cocoon_pressed():
	SkillPicker.chosen_skill = "CocoonSkill"
	SceneManager.LoadScene("res://scenes/Scene.tscn", self)


func _on_gunslinger_pressed():
	SkillPicker.chosen_skill = "GunslingerSkill"
	SceneManager.LoadScene("res://scenes/Scene.tscn", self)
