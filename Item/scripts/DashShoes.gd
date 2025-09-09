extends Tech
@export var amount : int = 0
func _ready():
	super()
	duplicate_flag = false
	price = 75
	effect_base_amount = amount
	item_name = "DashShoes"
	name = item_name
	display_name = "Dash Shoes"
	item_description = "The playe gain one more dash charge"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob():
	player.dash_charges += effect_base_amount
