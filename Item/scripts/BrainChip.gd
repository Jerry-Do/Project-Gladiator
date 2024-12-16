extends Tech


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	duplicate_flag = true
	price = 40
	item_name = "BrainChip"
	display_name = "Brain Chip"
	item_description = "Show the enemies' health and the their spawn location "
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null
