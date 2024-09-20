extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), 0.6)


# Called every frame. 'delta' is the elapsed time since the previous frame.
