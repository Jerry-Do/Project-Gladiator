extends EnvironmentProps
class_name DestructableProps


@export var is_destroyed : bool = false


	
func DestroyProp():
	null
	
func _on_timer_timeout():
	$EffectZone.show()
	$EffectZone/AnimationPlayer.play("activate")
