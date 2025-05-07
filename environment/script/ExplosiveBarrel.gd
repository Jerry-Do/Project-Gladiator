extends DestructableProps

func _ready():
	$EffectZone.monitoring = false
	$EffectZone.monitorable = false
	
func DestroyProp():
	if is_destroyed == false:
		$Timer.start(1.25)
		$Sprite2D.Blinking(Color.RED)
		is_destroyed = true





func _on_animation_player_animation_finished(anim_name):
	queue_free()
	
