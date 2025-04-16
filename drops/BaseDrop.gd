extends Area2D
class_name BaseDrop

@export var drop_resource : DropResource
# Called when the node enters the scene tree for the first time.
@onready var sprite : Sprite2D = $drop_sprite

var thing 
func _ready():
	sprite.texture = drop_resource.texture

func Effect(is_player : bool):
	queue_free()

func _on_area_entered(area : Area2D):
	if area.get_parent().name == "Player":
		thing = area.get_parent()
		Effect(true)
	if area.has_method("SetBuffForEnemy"):
		thing = area.get_parent()
		Effect(false)
