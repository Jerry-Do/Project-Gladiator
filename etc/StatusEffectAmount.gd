extends Resource
class_name SEADictionary
var debuff_dic : Dictionary[String, float] = {
	"slow" : 0.5,
	"vulnerable" : 0.2,
	"leech" : 0.03,
	"toxin" : 0.05,
	"fire" : 0.05,
	"bleed" : 0.05
}
var dot_dmg_timer : float = 1.0
var buff_dic : Dictionary[String, float] = {
	"speed": 1.5,
	"dmg": 1.2,
	"atk_speed": 0.8
}
