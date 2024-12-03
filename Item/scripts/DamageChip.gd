
extends Tech
@export var amount = 0



func _ready():
	super()
	duplicate_flag = true
	price = 5
	item_name = "DamageChip"
	display_name = "Damage Chip"
	item_description = "Increase the output damage by " + str(amount) + " %"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob(): 
	player.stats.SetBaseDamageMod((player.stats.ReturnBaseDamageMod() * ((amount * quantity)/100)))
	
