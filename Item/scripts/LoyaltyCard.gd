extends Tech
@export var amount = 0
@export var evo_amount = 0
@export var extra_stat_amount = 0

var stats : Stats
func _ready():
	super()
	duplicate_flag = false
	price = 5
	item_name = "LoyaltyCard"
	display_name = "Loyalty Card"
	item_description = "If the dominant item type is tech, then the future tech items will have a discount, based on the difference between the number of tech items and biochem (" + str(amount) + ") for 1 item"
	evolve_condition_text = "Have 5 tech items"
	if get_parent() == player.get_node("Item"):
		player_item.connect("add_type", self.EvoCheck)
	return null

func EvoCheck():
	if player_item.item_types.tech >= evo_amount:
		stats = player.stats
		var diff = clamp(player_item.tech - player_item.biochemical, player_item.tech - player_item.biochemical, 3)
		var real = (diff * extra_stat_amount) / 100
		stats.SetDamageMod(stats.stats.Base_Damage_Mod * real)
		
func UpdateDescription():
	item_description = "If the dominant item type is tech, then the future tech items will have a discount, based on the difference between the number of tech items and biochem (" + str(amount) + ") for 1 item"
