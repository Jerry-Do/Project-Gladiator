extends Biochemical



func _ready():
	super()
	duplicate_flag = false
	price = 14
	item_name = "EnemyHop"
	display_name = "Enemy Hop"
	name = item_name
	item_description = "If dash into an enemy, stun them and push both them and the player back"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null
