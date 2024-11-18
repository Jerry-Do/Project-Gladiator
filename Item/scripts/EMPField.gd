extends Item
@export var amount = 0


func _ready():
	duplicate_flag = false
	item_name = "EMPField"
	display_name = "EMP Field"
	item_description = "Decrease the movement speed of enemies in a radius"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob():
	$Timer.start()
	


func _on_area_2d_area_entered(area):
	if area.has_method("SetStatusOther"):
		area.SetStatusOther("slow", 1)


func _on_timer_timeout():
	$AnimationPlayer.play("emit")
