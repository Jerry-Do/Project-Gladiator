extends Tech

@export var damage = 1

func _ready():
	super()
	duplicate_flag = false
	price = 150
	item_name = "Laser Bot"
	display_name = "Laser Bot"
	name = item_name
	item_description = "Creates a bot that shoots out laser at the nearest enemy"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob():
	var laser_arm = preload("res://Item/etc/LaserArm.tscn")
	var real = laser_arm.instantiate()
	real.position = Vector2(0, -41)
	real.rotation = player.rotation
	real.damage = damage
	player.add_child(real)
