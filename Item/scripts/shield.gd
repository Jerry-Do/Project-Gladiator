
extends Tech
@export var amount = 0
var recharge_flag = false
@export var evo_amount = 0
var current_damage_blocked = 0

func _ready():
	super()
	duplicate_flag = true
	price = 50
	item_name = "EnergyShield"
	effect_base_amount = amount
	name = item_name
	display_name = "Energy Shield"
	item_description = "Gives the player a shield"
	faction = "tech"
	evolve_condition_text = ""
	if get_parent() == player.get_node("Item"):
		DoJob()
		$Sprite2D.hide()
		player.healthBar.shield_bar.show()
		
	return null

func _process(delta):
	if recharge_flag:
		player.shield_amount += delta
		player.healthBar._set_shield(player.shield_amount)

func TakingDamage(amount : float):
	current_damage_blocked += amount
	$Timer.start()

func _on_timer_timeout():
	player.shield_amount += 1
	player.healthBar._set_shield(player.shield_amount)
	
func DoJob():
	player.shield_amount = amount * quantity
	player.healthBar.init_shield(amount)
