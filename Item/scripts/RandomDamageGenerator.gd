
extends Tech

var old_amount : float = 0.0
@export var percentage = 0.0
func _ready():
	super()
	duplicate_flag = false
	price = 100
	item_name = "R.D.G"
	display_name = "R.D.G"
	name = item_name
	item_description = "At the start of every round gain a random amount of dmg mod between of the -current balnce and the current balance"
	if get_parent() == player.get_node("Item"):
		GameManager.instance.connect("RoundStart", self.DoJob)
	return null

func DoJob(): 
	var calculation :float = GameManager.instance.currency *(percentage / 100.0)
	var random_amount = randi_range(-calculation, calculation)
	player.stats.SetDamageMod(-old_amount)
	old_amount = random_amount
	player.stats.SetDamageMod(random_amount)
