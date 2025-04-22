extends Area2D

func _ready():
	$Timer.start(0.6)

func _on_area_entered(area):
	if area.has_method("SetStatusOther"):
		area.SetStatusOther("toxin", 5)
	


func _on_timer_timeout():
	queue_free()
