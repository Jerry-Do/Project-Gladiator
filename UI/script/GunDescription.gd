extends Control



func _ready():
	get_tree().paused = true
	
func SetUp(w_name : String, w_description : String) -> void:
	%Name.text = w_name
	%Description.text = w_description

	


func _on_button_pressed():
	get_tree().paused = false
	queue_free()
