
extends Tech
@export var amount = 0



func _ready():
	super()
	duplicate_flag = true
	price = 10
	item_name = "CoolingSystem"
	display_name = "Cooling System"
	item_description = "Decrase the recharge time for time stop by " + str(amount) + " %"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob(): 
	player.stats.SetChargeTime(-(player.stats.ReturnChargeTime() * ((amount * quantity) / 100)))
