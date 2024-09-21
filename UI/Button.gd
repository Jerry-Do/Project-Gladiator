extends Control

@export var items : Array
@onready var item_sprite = $ItemSprite
@onready var description = $Description
@onready var game_manager = get_node("../../../GameManager")
# Called when the node enters the scene tree for the first time.
#func _ready():
	#add_child(new_item)
	#var child = get_child(3)
	#child.item_sprite.hide()
	#item_sprite.texture = child.ReturnItemSprite()
	#description.text = child.ReturnItemDescription()
	#remove_child(new_item)
#
#
#
#func _on_texture_button_pressed():
	#game_manager.UpgradeChose(items[0])
