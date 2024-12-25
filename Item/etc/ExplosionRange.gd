extends Area2D



func  _ready():
	%AnimationPlayer.play("explosion")
	
func _on_area_entered(area):
	if area.has_method("TakingDamageForOther"):
		area.TakingDamageForOther(5, false)


func _on_animation_player_animation_finished(anim_name):
	queue_free()
