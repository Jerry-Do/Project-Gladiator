
extends Item
@export var amount = 0



func _ready():
	item_name = "EnergyCell"
	display_name = "Energy Cell"
	item_description = "Increase the duration of time slow"
	if get_parent() == player.get_child(6):
		DoJob()
	return null

func DoJob(): 
	player.stats.maxDashSpeed = player.stats.maxDashSpeed * (1 + ((amount * quantity)/100))
