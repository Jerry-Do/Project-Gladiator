extends Area2D

@export var damage = 10
@export var orbital_strike_wait_time = 0



func _on_timer_timeout():
	$Marker.hide()
	$StrikeSprite.show()
	$AnimationPlayer.play("strike")


func _on_area_entered(area):
	if area.has_method("TakingDamageForOther"):
		area.TakingDamageForOther(damage, false, "", false)
		area.SetStatusOther("stun", 2)
	if area.has_method("TakingDamageForPlayer"):
		area.TakingDamageForPlayer(-damage, false, null)
		area.SetStatusPlayer("stun", 2)


func _on_animation_player_animation_finished(anim_name):
	self.queue_free()
