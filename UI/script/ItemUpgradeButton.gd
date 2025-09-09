extends Control

var item_path : String
@onready var item_sprite = $ItemSprite
@onready var texture_button = $TextureButton
@onready var description = %Description
@onready var price_label = %price
@onready var faction_label = %faction
@onready var item_name_label = %name
@onready var game_manager : GameManager = get_tree().get_first_node_in_group("GameManager")
@export var discount_threshold = 0
var item_name
var price
# Called when the node enters the scene tree for the first time
signal ChooseItem(item_path,item_name,price)

func intialize(new_item_path):
	if new_item_path != null:
		var player_item : PlayerItem = game_manager.player.get_node("Item")
		if new_item_path != null:
			connect("ChooseItem", game_manager.UpgradeChose)
		item_path = new_item_path
		var item = load(new_item_path)
		var new_item : Item = item.instantiate()
		var discount_flag : bool = false
		add_child(new_item)
		match new_item.ReturnFaction().to_lower():
			"biochemical":
				var normal_texture = preload("res://Sprite/UI/biobutton1.png")
				var press_texture = preload("res://Sprite/UI/biobutton2.png")
				texture_button.set_texture_normal(press_texture)
				texture_button.set_texture_pressed(press_texture)
			"r.i.s.k":
				var normal_texture = preload("res://Sprite/UI/gamblebutton1.png")
				var press_texture = preload("res://Sprite/UI/gamblebutton2.png")
				texture_button.set_texture_normal(press_texture)
				texture_button.set_texture_pressed(press_texture)				
		new_item.item_sprite.hide()
		item_sprite.texture = new_item.ReturnItemSprite()
		description.text = new_item.ReturnItemDescription()
		item_name = new_item.ReturnName()
		item_name_label.text = new_item.ReturnDisplayName()
		faction_label.text = new_item.ReturnFaction()
		price = new_item.ReturnPrice()
		if game_manager.currentFame >= discount_threshold && new_item.ReturnFaction() != player_item .dominant_type:
			var random_no = randi_range(0,1)
			if random_no == 1:
				discount_flag = true
				price /= 2
		if player_item.get_node_or_null("LoyaltyCard") != null:
			pass
		price_label.text = "Price: " + str(price)
		if new_item.ReturnEvoText() != null:
			%EvoCon.text = "EvoCon: " + new_item.ReturnEvoText()
		remove_child(new_item)
	else:
		queue_free()
#
func _on_texture_button_pressed():
	ChooseItem.emit(item_path,item_name,price )
	


func _on_timer_timeout():
	$TextureButton.disabled = false
