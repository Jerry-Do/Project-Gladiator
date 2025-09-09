extends Tech
@export var amount = 0


func _ready():
	super()
	duplicate_flag = true
	price = 30
	effect_base_amount = amount
	item_name = "IllegalModification"
	display_name = "Illegal Modification"
	name = item_name
	item_description = "Increase fire rate"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null
