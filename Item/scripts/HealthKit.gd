
extends Biochemical
@export var amount : float = 0
#Evo con: regens enough health
#Evo effect: regen rate is faster
@export var evo_amount = 0
var health_regened = 0

func _ready():
	super()
	duplicate_flag = true
	price = 150
	effect_base_amount = amount
	item_name = "RegenarativeTissue"
	display_name = "Regenarative Tissue"
	name = item_name
	item_description = "Player regenerates " + str(EffectAmount()) + " health overtime, health regeneration rate is increased when evolved"
	evolve_condition_text = "Regenerate " + str(evo_amount) + " health"
	return null



func _on_timer_timeout():
	if get_parent() == player.get_node("Item"):
		player.stats.SetHealth(amount * quantity)
		player.healthBar._set_health(player.stats.ReturnHealth())
		EvolveCheck()

func EvolveCheck():
	if health_regened >= evo_amount && evolve_flag == false:
		$Timer.wait_time /= 2
		evolve_flag = true
		
func UpdateDescription():
	item_description = "Player regenerates " + str(EffectAmount()) + " health overtime, health regeneration rate is increased when evolved"
