
extends Item
@export var amount = 0



func _ready():
	item_name = "DamageChip"
	display_name = "Damage Chip"
	item_description = "Increase the output damage by " + str(amount) + " %"
	if get_parent() == player.get_child(6):
		DoJob()
	return null

func DoJob(): 
	player.stats.SetDamageMod(player.stats.ReturnDamageMod() * ((amount * quantity)/100))
	
