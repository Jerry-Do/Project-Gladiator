extends Sprite2D
class_name HitFlash
var tween : Tween

func HitFlash():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "material:shader_parameter/hit_flash_on", true, 0.1)
	tween.tween_property(self, "material:shader_parameter/hit_flash_on", false, 0.1)


func _on_timer_timeout():
	pass # Replace with function body.
