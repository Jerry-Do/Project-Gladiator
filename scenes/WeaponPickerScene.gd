extends Node2D

@export var weapon_array : Array = []

func _ready():
	for i in weapon_array.size():
		var button : Button	= Button.new()
		button.text = weapon_array[i]
		button.name = weapon_array[i]
		button.pressed.connect(_on_button_pressed.bind(button))
		$Control/VBoxContainer.add_child(button)
		
		
func _on_button_pressed(button: Button):
	ThingsPicker.chosen_weapon = button.text
	SceneManager.LoadScene("res://scenes/Scene.tscn", self)
