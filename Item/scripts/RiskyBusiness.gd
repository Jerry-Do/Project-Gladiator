extends Risk


@export var amount = 0
@export var m_price = 0
func _ready():
	super()
	duplicate_flag = false
	price = m_price
	item_name = "RiskyBusiness"
	display_name = "Risky Business"
	name = item_name
	effect_base_amount = amount
	item_description = "Allows the player to go into debt, but the enemies's stats will be increased based "
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null
