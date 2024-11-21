
extends Item
@export var amount = 0
var recharge_flag = false
@export var evo_amount = 0
var current_damage_blocked

func _ready():
	duplicate_flag = true
	item_name = "EnergyShield"
	display_name = "Energy Shield"
	item_description = "Gives the player a shield of " + str(amount) + " damage." + \
	"When evolved, the shield will explode and stun surrouding enemies for 1 second"
	evolve_condition_text = ""
	if get_parent() == player.get_node("Item"):
		DoJob()
		$Sprite2D.hide()
		$Area2D/CollisionShape2D.disabled = true
		player.healthBar.shield_bar.show()
		
	return null

func _process(delta):
	if recharge_flag:
		player.shield_amount += delta
		player.healthBar._set_shield(player.shield_amount)

func TakingDamage(amount : float):
	current_damage_blocked += amount
	if current_damage_blocked >= evo_amount:
		evolve_flag = true
	if player.shield_amount <= 0 && evolve_flag:
		$AnimationPlayer.play("explode")
	$Timer.start()

func _on_timer_timeout():
	player.shield_amount += 1
	player.healthBar._set_shield(player.shield_amount)
	
func DoJob():
	player.shield_amount = amount * quantity
	player.healthBar.init_shield(amount)


func _on_area_2d_area_entered(area):
	if area.has_method("SetStatusOther"):
		area.SetStatusOther("stun", 1)
