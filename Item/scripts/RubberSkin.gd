
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
	name = item_name
	item_description = "Reflect damage back to the enemies"
	if get_parent() == player.get_node("Item"):
		player.get_node("Back").connect("getting_hit", self.ReflectDamage)
		player.get_node("Front").connect("getting_hit", self.ReflectDamage)
	return null

func ReflectDamage(attacker : Enemy, amount : float):
	if attacker != null:
		var random = 0
		var crit_chance = 100 - player.stats.ReturnCritChance()
		if player.get_node("Item").item_critable:
			random = RandomNumberGenerator.new().randi_range(1, crit_chance)
		var reflect_dmg = abs(amount * (2 if random == crit_chance else 1)) * (reflect_percentage / 100.0)
		no_times_getting_hit += 1

func UpdateDescription():
	item_description = "Reflect " + str(reflect_percentage) +"% pre-mitigated damage dealt to the player. After evolving, also heals " + str(heal_percentage) +"of"
