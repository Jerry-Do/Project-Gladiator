extends Biochemical
@export var amount : float
@onready var hitbox : Area2D = $Area2D
func _ready():
	super()
	duplicate_flag = false
	price = 60
	effect_base_amount = amount
	item_name = "HardenShoulder"
	name = item_name
	display_name = "Harden Shoulder"
	item_description = "Dash through enemy will also damage them"
	return null

func _process(delta):
	if player.state_controller.current_state.name == "Dash":
		hitbox.monitoring = true
	else:
		hitbox.monitoring = false
	
func _on_area_2d_area_entered(area):
	var crit_chance = 100 - player.stats.ReturnCritChance()
	var random = RandomNumberGenerator.new().randi_range(1, crit_chance + 1)
	area.TakingDamageForOther(effect_base_amount, false, faction, (random == crit_chance))
