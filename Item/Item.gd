extends Node

class_name Item

@onready var sprite = %Sprite

func _on_body_entered(body):
	if body.has_method("PickUpItem"):
		body.PickUpItem(self)

func GetSpritePath():
	return sprite.texture.resource_path
