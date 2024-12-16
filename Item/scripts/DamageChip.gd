
extends Tech
@export var amount = 0



func _ready():
	super()
	duplicate_flag = true
	price = 5
	effect_base_amount = amount
	item_name = "DamageChip"
	display_name = "Damage Chip"
	item_description = "Increase damage mod by " + str(EffectAmount()) + " %"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob(): 
	player.stats.SetDamageMod((player.stats.ReturnBaseDamageMod() * ((EffectAmount())/100)))

func UpdateDescription():
	item_description = "Increase the output damage by " + str(EffectAmount()) + " %"
