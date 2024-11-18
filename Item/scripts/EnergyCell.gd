
extends Item
@export var amount = 0



func _ready():
	duplicate_flag = true
	item_name = "EnergyCell"
	display_name = "Energy Cell"
	item_description = "Increase the duration of time slow by" +str(amount) + " %"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob(): 
	player.stats.maxDashSpeed = player.stats.maxDashSpeed * (1 + ((amount * quantity)/100))
