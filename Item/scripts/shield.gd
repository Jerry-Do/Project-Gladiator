
extends Item
@export var amount = 0
@onready var player = get_tree().get_first_node_in_group("player")
var recharge_flag = false

func _ready():
	item_name = "Engery Shield"
	item_description = "Gives the player a shield"
	if get_parent() == player.get_child(6):
		player.shield_amount = amount
		player.healthBar.shield_bar.show()
		player.healthBar.init_shield(amount)
	return null

func _process(delta):
	if recharge_flag:
		player.shield_amount += delta
		player.healthBar._set_shield(player.shield_amount)

func TakingDamage():
	$Timer.start()

func _on_timer_timeout():
	player.shield_amount += 1
	player.healthBar._set_shield(player.shield_amount)
