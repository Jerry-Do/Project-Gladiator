extends Node
class_name Item
@onready var player = get_tree().get_first_node_in_group("player")
@onready var item_sprite = $ItemSprite
@onready var item_description
var item_name
var display_name
var quantity = 1 : set = _set_quantity

func ReturnItemSprite():
	return item_sprite.texture

func ReturnItemDescription():
	return item_description

func ReturnName():
	return item_name

func ReturnDisplayName():
	return display_name


func _set_quantity(amount):
	quantity += amount
