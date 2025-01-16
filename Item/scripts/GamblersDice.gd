extends Risk


@export var amount = 0
@export var m_price = 0
func _ready():
	super()
	duplicate_flag = false
	price = m_price
	item_name = "GamblerDice"
	display_name = "Gambler's Dice"
	name = item_name
	effect_base_amount = amount
	item_description = "Killing an enemy will grand an addtion random amount of material"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null
