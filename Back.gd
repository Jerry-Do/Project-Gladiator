extends CollisionShape2D
class_name Back

@export var default_position: Vector2:
	set(new_position):
		default_position = new_position
		position = new_position


var current_flip_value: bool

func _on_sprite_flipped(flip_value):
	if current_flip_value != flip_value:
		
		default_position *= -1
		current_flip_value = flip_value
		print(position)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
