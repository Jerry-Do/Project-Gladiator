extends Risk
@export var amount : int = 0
func _ready():
	super()
	duplicate_flag = true
	price = 5
	effect_base_amount = amount
	item_name = "SleightOfHand"
	name = item_name
	display_name = "Sleight Of Hand"
	item_description = "Reduce reload time"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null
