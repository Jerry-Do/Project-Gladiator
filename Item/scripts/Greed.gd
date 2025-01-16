extends Risk

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	duplicate_flag = false
	price = 40
	item_name = "Greed"
	display_name = "Greed"
	name = item_name
	item_description = "At the end of every round, either double or half the current amount of currency"
	if get_parent() == player.get_node("Item"):
		DoJob()
		GameManager.instance.connect("RoundEnd", self.DoJob)
	return null

func DoJob():
	var random_no = randi_range(0,1);
	match random_no:
		0:
			GameManager.instance.AdjustCurrency(-(GameManager.instance.currency/2))
		1:
			GameManager.instance.AdjustCurrency(GameManager.instance.currency/2)
