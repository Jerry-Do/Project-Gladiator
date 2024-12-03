
extends Tech
@export var amount = 0



func _ready():
	super()
	duplicate_flag = true
	price = 5
	item_name = "EnergyCell"
	display_name = "Energy Cell"
	item_description = "Increase the duration of time slow by" +str(amount) + " %"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob(): 
	player.stats.stats.Dash_Time = player.stats.stats.Dash_Time * (1 + ((amount * quantity)/100))
