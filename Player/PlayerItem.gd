extends Node2D
class_name PlayerItem
var item_sets = {
	"berserk" : false,
	"bioenhancement" : false,
	"r.i.s.k" : false
}
var item_types : Dictionary = {
	"biochemical" : 0,
	"tech" : 0,
	"r.i.s.k" : 0
}
signal add_type()
var dominant_type : String = ""

func IncreaseType(type:String):
	item_types[type.to_lower()] += 1
	add_type.emit()


	
	
