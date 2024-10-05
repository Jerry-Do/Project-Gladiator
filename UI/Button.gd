extends Control

var item_path : String
@onready var item_sprite = $ItemSprite
@onready var description = %Description
@onready var game_manager = get_node("../../../GameManager")
# Called when the node enters the scene tree for the first time
signal ChooseItem(item_path)

func intialize(new_item_path):
	if new_item_path != null:
		connect("ChooseItem", game_manager.UpgradeChose)
		item_path = new_item_path
		var item = load(new_item_path)
		var new_item = item.instantiate()
		add_child(new_item)
		new_item.item_sprite.hide()
		item_sprite.texture = new_item.ReturnItemSprite()
		description.text = new_item.ReturnItemDescription()
		remove_child(new_item)
	else:
		queue_free()
#
func _on_texture_button_pressed():
	ChooseItem.emit(item_path)
	#game_manager.UpgradeChose()
