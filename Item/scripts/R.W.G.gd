extends Risk


@export var wait_time : float = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	duplicate_flag = false
	price = 200
	item_name = "RandomWeaponGenerator"
	name = item_name
	display_name = "R.W.G"
	item_description = "Weapons will no longer naturally spawned, but after " + str(wait_time) + " the player will equip new weapon"
	if get_parent() == player.get_node("Item"):
		GameManager.instance.can_spawn_weapon = false
		$Timer.start(wait_time)
	return null




func _on_timer_timeout():
	var random_weapon = randi_range(0, GameManager.instance.weapons.size() - 1)
	var weapon = load(GameManager.instance.weapons[random_weapon])
	var real = weapon.instantiate()
	real.position = player.global_position
	GameManager.instance.get_parent().add_child(real)
