extends Control



func _ready():
	await get_tree().create_timer(5).timeout
	queue_free()
	
func SetUp(w_name : String, w_description : String) -> void:
	%Name.text = w_name
	%Description.text = w_description



	
