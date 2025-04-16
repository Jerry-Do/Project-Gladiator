extends Node2D
class_name PlayerItem
var item_sets = {
	"berserk" : false,
	"bioenhancement" : false,
}
var item_types : Dictionary = {
	"biochemical" : 0,
	"tech" : 0,
	"r.i.s.k" : 0
}
var dominant_type : String = "biochemical"
var item_critable : bool = false
var is_dominant_type_set : bool = false
#The thresh hold can be changed by changing the var below
var dominant_thresh_hold : int = 0
signal add_type()


func IncreaseType(type:String):
	item_types[type.to_lower()] += 1
	add_type.emit()
	if item_types[type.to_lower()] == dominant_thresh_hold:
		dominant_type = type.to_lower()


	
	
