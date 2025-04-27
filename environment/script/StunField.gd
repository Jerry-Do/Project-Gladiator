extends DestructableProps

func _ready():
	$EffectZone.monitoring = false
	
func DestroyProp():
	if is_destroyed == false:
		$Timer.start(1.25)
		$DestroyTimer.start(3)
		$Sprite2D.Blinking(Color.YELLOW)
		is_destroyed = true
	
	
	
		


func _on_explosion_zone_area_entered(area):
	var is_player = null
	if area.has_method("TakingDamageForOther"):
		area.SetStatusOther("stun", 2)
	if area.has_method("SetStatusPlayer"):
		area.SetStatusPlayer("stun", 2) 

	


func _on_destroy_timer_timeout():
	queue_free()


func _on_area_entered(area):
	DestroyProp()
