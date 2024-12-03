extends Node2D

var item_types : Dictionary = {
	"biochemical" : 0,
	"tech" : 0
}
var dominant_type : String = ""
func IncreaseType(type:String):
	
	item_types[type.to_lower()] += 1
	dominant_type = "biochemical" if item_types.biochemical >  item_types.tech else "tech"
	print(dominant_type)
	
	
	
