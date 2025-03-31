
extends Tech
@export var amount = 0


func _ready():
	super()
	duplicate_flag = false
	price = 14
	effect_base_amount = amount
	item_name = "GoldenGloves"
	display_name = "Golden Gloves"
	name = item_name
	item_description = "Increase crit rate by " + str(EffectAmount()) + " %"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob():
	player.can_crit = true
	player.stats.SetCritChance(amount)

func UpdateDescription():
	item_description = "Increase crit rate by " + str(EffectAmount()) + " %"
