extends Node2D


func _on_time_slow_pressed():
	ThingsPicker.chosen_skill = "TimeSlowSkill"
	SceneManager.LoadScene("res://scenes/WeaponPickerScene.tscn", self)


func _on_cocoon_pressed():
	ThingsPicker.chosen_skill = "CocoonSkill"
	SceneManager.LoadScene("res://scenes/WeaponPickerScene.tscn", self)


func _on_gunslinger_pressed():
	ThingsPicker.chosen_skill = "GunslingerSkill"
	SceneManager.LoadScene("res://scenes/WeaponPickerScene.tscn", self)
