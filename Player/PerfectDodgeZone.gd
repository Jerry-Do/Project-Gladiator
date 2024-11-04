extends Area2D

@onready var time_stop_state  = %TimeStop 

func _on_area_entered(area):
	$Timer.start()
	
