extends DestructableProps

func _ready():
	$ExplosionZone.monitoring = false
	
func DestroyProp():
	$Sprite2D.hide()
	$ExplosionZone.show()
	$ExplosionZone/AnimationPlayer.play("explosion")
	
		


func _on_explosion_zone_area_entered(area):
	if area.has_method("TakingDamageForOther"):
		area.TakingDamageForOther(10, false, area.get_parent().faction, false)


func _on_animation_player_animation_finished(anim_name):
	queue_free()
