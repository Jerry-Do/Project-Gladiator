extends Control
@onready var game_manager : GameManager = get_tree().get_first_node_in_group("GameManager")
#Debug tool too add an item to the player when testing the game

func _on_item_list_item_selected(index):
	var item_name = $ItemList.get_item_text(index)
	var path = "res://Item/" + item_name + ".tscn"
	game_manager.UpgradeChose(path, item_name)
	
