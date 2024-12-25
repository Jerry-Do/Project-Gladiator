
extends Tech
@export var amount = 0



func _ready():
	super()
	duplicate_flag = true
	price = 10
	effect_base_amount = amount
	item_name = "CoolingSystem"
	display_name = "Cooling System"
	item_description = "Decrase the recharge time for time stop by " + str(EffectAmount()) + " %"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob(): 
	player.stats.SetChargeTime(-(player.stats.ReturnChargeTime() * ((EffectAmount()) / 100.00)))
	
func UpdateDescription():
	item_description = "Decrase the recharge time for time stop by " + str(EffectAmount()) + " %"
