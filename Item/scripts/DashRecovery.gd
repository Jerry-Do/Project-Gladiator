extends Biochemical
@export var amount: float  = 0

var fullset = false

func _ready():
	super()
	duplicate_flag = true
	price = 5
	effect_base_amount = amount
	item_name = "DashRecovery"
	name = item_name
	display_name = "Dash Recovery"
	item_description = "Reduce cooldown for dash"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob(): 
	var amount = player.stats.ReturnDashCooldown() * (effect_base_amount / 100.00)
	player.stats.SetDashCooldown(-amount)
