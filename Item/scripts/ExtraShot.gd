extends Tech


# Called when the node enters the scene tree for the first time.

func _ready():
	super()
	duplicate_flag = false
	price = 200
	item_name = "ExtraShot"
	name = item_name
	display_name = "Extra Shot"
	item_description = "Shoots an extra shot"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null

func DoJob():
	player.get_node("Item").num_shot += 1


	
