extends Node
class_name Item
@onready var player = get_tree().get_first_node_in_group("player")
@onready var item_sprite = $ItemSprite
@onready var item_description
var duplicate_flag : bool
var faction : String
var item_name : String
var display_name : String
var evolve_condition_text : String
var evolve_flag : bool = false
var quantity = 1 : set = _set_quantity
var price : int

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
	_set_quantity(1)
	DoJob()
