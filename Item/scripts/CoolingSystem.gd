
extends Tech
@export var amount = 0



func _ready():
	super()
	duplicate_flag = true
	price = 25
	effect_base_amount = amount
	item_name = "CoolingSystem"
	display_name = "Cooling System"
	name = item_name
	item_description = "Remove overheat effect"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null


	
	
