
extends Item
@export var amount = 0


func _ready():
	item_name = "GoldenGloves"
	display_name = "Golden Gloves"
	item_description = "Increase crit rate by " + str(amount) + " %"
	if get_parent() == player.get_child(6):
		DoJob()
	return null

func DoJob():
	player.can_crit = true
	player.stats.SetCritChance(5)
