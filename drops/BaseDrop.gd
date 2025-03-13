extends Area2D
class_name BaseDrop

@export var drop_resource : DropResource
# Called when the node enters the scene tree for the first time.
@onready var sprite : Sprite2D = $drop_sprite

var player : Player 
func _ready():
	sprite.texture = drop_resource.texture

func Effect():
	queue_free()

func _on_area_entered(area : Area2D):
	if area.get_parent().name == "Player":
		player = area.get_parent()
		Effect()
