
extends Tech
@export var amount = 0



func _ready():
	super()
	duplicate_flag = true
	price = 5
	item_name = "EnergyCell"
	display_name = "Energy Cell"
	effect_base_amount = amount
	name = item_name
	item_description = "Increase the duration of time slow by" +str(EffectAmount()) + " %"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob(): 
	player.stats.stats.Dash_Time = player.stats.stats.Dash_Time * (1.0+ ((amount * quantity)/100.0))

func UpdateDescription():
	item_description = "Increase the duration of time slow by" +str(EffectAmount()) + " %"
