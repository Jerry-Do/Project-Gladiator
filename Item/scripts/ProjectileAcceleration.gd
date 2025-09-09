extends Tech
@export var amount = 0
@export var dmg_per_distant : int = 0

func _ready():
	super()
	duplicate_flag = true
	price = 40
	effect_base_amount = amount
	item_name = "ProjectileAcceleration"
	display_name = "Projectile Acceleration"
	name = item_name
	item_description = "Increase damage of projectile based on the distance traveled"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null
