
extends Biochemical

@export var reflect_percentage : int
@export var heal_percentage : int
@export var evolve_amount : int 
var player_flag = false
var no_times_getting_hit = 0

func _ready():
	super()
	duplicate_flag = false
	price = 30
	item_name = "RubberSkin"
	display_name = "Rubber Skin"
	item_description = "Reflect " + str(reflect_percentage) +"% pre-mitigated damage dealt to the player. After evolving, also heals " + str(heal_percentage) +"of"
	evolve_condition_text = "Getting hit 20 times"
	if get_parent() == player.get_node("Item"):
		player.get_node("Back").connect("getting_hit", self.ReflectDamage)
		player.get_node("Front").connect("getting_hit", self.ReflectDamage)
	return null

func ReflectDamage(attacker : Enemy, amount : float):
	var reflect_dmg = abs(amount) * (reflect_percentage / 100.0)
	no_times_getting_hit += 1
	if no_times_getting_hit >= evolve_amount:
		var heal_amount = reflect_percentage * (heal_percentage / 100)
		player.stats.SetHealth(heal_amount)
