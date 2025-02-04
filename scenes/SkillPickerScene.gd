extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_time_slow_pressed():
	SkillPicker.chosen_skill = "TimeSlowSkill"
	SceneManager.LoadScene("res://scenes/Scene.tscn", self)


func _on_cocoon_pressed():
	SkillPicker.chosen_skill = "CocoonSkill"
	SceneManager.LoadScene("res://scenes/Scene.tscn", self)
