extends Sprite2D

var tween : Tween

func Blinking(color : Color):
	if tween:
		tween.kill()
	tween = create_tween().set_loops()
	tween.tween_property(self, "self_modulate", color, 0.2)
	tween.tween_property(self, "self_modulate", Color.WHITE, 0.2)
