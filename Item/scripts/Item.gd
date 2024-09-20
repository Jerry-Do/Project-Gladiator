extends Node
class_name Item

@onready var item_sprite = $ItemSprite
@onready var item_description

func ReturnItemSprite():
	return item_sprite.texture

func ReturnItemDescription():
	return item_description
