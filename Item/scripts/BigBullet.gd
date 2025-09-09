extends Tech
@export var amount : int = 50
func _ready():
	super()
	duplicate_flag = false
	price = 50
	effect_base_amount = amount
	item_name = "BigBullet"
	name = item_name
	display_name = "Big Bullet"
	item_description = "Increase Bullet Size"
	if get_parent() == player.get_node("Item"):
		var bb = preload("res://Item/bullet_upgrades_res/BigBullet.tres")
		bb.amount = amount
		player.get_node("Item").AddBulletUpgrade(bb)
	return null
