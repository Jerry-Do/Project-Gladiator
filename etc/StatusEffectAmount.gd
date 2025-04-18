extends Node
class_name SEADictionary
static var singleton : SEADictionary = null
var debuff_dic : Dictionary[String, float] = {
	"slow" : 0.5,
	"vulnerable" : 0.2,
	"leech" : 0.3,
	"poison" : 0.5
}

var buff_dic : Dictionary[String, float] = {
	
}

func _ready():
	singleton = self
