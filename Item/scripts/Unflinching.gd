extends Biochemical
@export var amount : float = 0

var old_armor : float = 0
var changed_flag : bool = false
##TODO: test the item
func _ready():
	super()
	duplicate_flag = true
	price = 14
	effect_base_amount = amount
	item_name = "Unfliching"
	display_name = "Unfliching"
	name = item_name
	item_description = "Increase player's armor if they are not moving"
	return null


func _process(delta):
	if get_parent().name == "Item":	
		if player.velocity == Vector2.ZERO && changed_flag == false:
			old_armor = player.stats.stats["Armor"]
			var new_armor = old_armor * (1.0 + amount)
			player.stats.stats["Armor"] = new_armor
			changed_flag = true
		elif player.velocity != Vector2.ZERO:
			player.stats.stats["Armor"] = old_armor
			changed_flag = false
