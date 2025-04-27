extends DestructableProps

func _ready():
	$EffectZone.monitoring = false
	
func DestroyProp():
	if is_destroyed == false:
		$Timer.start(1.25)
		$Sprite2D.Blinking(Color.RED)
		is_destroyed = true
	
	
	
		


func _on_explosion_zone_area_entered(area):
	var is_player = null
	if area.has_method("TakingDamageForOther"):
		area.TakingDamageForOther(10, false, area.get_parent().faction, false)
	if  area.has_method("TakingDamageForPlayer"):
		area.TakingDamageForPlayer(10, false, null)



func _on_animation_player_animation_finished(anim_name):
	queue_free()
	
