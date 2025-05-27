extends Node2D
class_name PlayerItem
var num_items : int = 0
var item_sets = {
	"berserk" : false,
	"bioenhancement" : false,
}
var item_types : Dictionary = {
	"biochemical" : 0,
	"tech" : 0,
	"r.i.s.k" : 0
}
var bullet_upgrades : Array
var player : Player = get_parent()
var num_shot : int = 1
var dominant_type : String = ""
var item_critable : bool = false
var is_dominant_type_set : bool = false
#The thresh hold can be changed by changing the var below
var dominant_thresh_hold : int = 0
signal add_type()


func IncreaseType(type:String):
	num_items += 1
	item_types[type.to_lower()] += 1
	add_type.emit()
	if item_types[type.to_lower()] == dominant_thresh_hold:
		dominant_type = type.to_lower()


func AddBulletUpgrade(upgrade :BaseBulletUpgrade):
	bullet_upgrades.append(upgrade)
	
