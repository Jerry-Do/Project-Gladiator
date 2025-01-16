extends Risk


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	duplicate_flag = true
	price = 100
	item_name = "ItemOverclock"
	name = item_name
	display_name = "Item Overclock"
	item_description = "All damage from items are critable"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null
	
func DoJob():
	player.get_node("Item").item_critable = true
