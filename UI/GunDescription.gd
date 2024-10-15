extends Control


# Called when the node enters the scene tree for the first time.
func SetUp(w_name : String, w_description : String) -> void:
	%Name.text = w_name
	%Description.text = w_description


func _on_timer_timeout():
	queue_free()
