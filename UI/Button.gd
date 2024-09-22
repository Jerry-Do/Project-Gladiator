extends Control

var item_path : String
@onready var item_sprite = $ItemSprite
@onready var description = %Description
@onready var game_manager = get_node("../../../GameManager")
# Called when the node enters the scene tree for the first time


func intialize(new_item_path):
	item_path = new_item_path
	var item = load(new_item_path)
	var new_item = item.instantiate()
	add_child(new_item)
	new_item.item_sprite.hide()
	item_sprite.texture = new_item.ReturnItemSprite()
	description.text = new_item.ReturnItemDescription()
	remove_child(new_item)
#
func _on_texture_button_pressed():
	game_manager.UpgradeChose(item_path)
