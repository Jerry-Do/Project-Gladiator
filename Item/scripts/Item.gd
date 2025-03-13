extends Node2D
class_name Item
@onready var player : Player = get_tree().get_first_node_in_group("player")
@onready var player_item = player.get_node("Item")
@onready var item_sprite = $ItemSprite
@onready var item_description
var duplicate_flag : bool
var faction : String
var item_name : String
var critable : bool = false
var display_name : String
var evolve_condition_text : String
var evolve_flag : bool = false
var effect_base_amount : float = 0
var quantity = 1 : set = _set_quantity
var price : int
var can_crit : bool

func ReturnItemSprite():
	return item_sprite.texture

func ReturnItemDescription():
	return item_description
	
func ReturnPrice():
	return price 
	
func ReturnName():
	return item_name

func ReturnDisplayName():
	return display_name

func DoJob():
	return null

func _set_quantity(amount):
	quantity += amount

func ReturnEvoText():
	return evolve_condition_text

func ReturnFaction():
	return faction
	
func Duplicate():
	if duplicate_flag == true:
		_set_quantity(1)
		call("UpdateDescription")
		DoJob()

func EffectAmount():
	return quantity * effect_base_amount
	
