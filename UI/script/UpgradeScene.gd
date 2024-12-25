extends Control
@export var c_items : Array
@export var u_items : Array
@export var r_items : Array
var array_to_use : Array
var spawned_items : Array
@onready var game_manager : GameManager = get_tree().get_first_node_in_group("GameManager")
@onready var player : Player = get_tree().get_first_node_in_group("player")
var rng_gen = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	%UpgradeBtn.tooltip_text = "Takes " + str(player.stats.stats.Level * 10) + " currency to increase health, base damage mod, and more by 1"
	var player_items = player.get_node("Item")
	for child in $ButtonsContainer.get_children():
		randomize()
		var random_amount = rng_gen.randi_range(0,game_manager.currentFame) / 1000.0		
		var random_noo =  randf_range(0.0,1.0) + random_amount
		if random_noo < 0.8:
			array_to_use = c_items
		elif random_noo < 0.95:
			array_to_use = u_items
		else:
			array_to_use = r_items
		var no_duplicate = false
		var no_repeat = false
		var random_no =  rng_gen.randi_range(0, array_to_use.size() - 1)
		var counter = 0
		while no_repeat == false  || no_duplicate == false: 
			no_duplicate = true
			no_repeat = true
			counter += 1
			random_no =  rng_gen .randi_range(0,array_to_use.size() - 1)
			var item = load(array_to_use[random_no])
			var real = item.instantiate()
			add_child(real)
			if real.duplicate_flag == false:
				if player_items.find_child(real.item_name, false, false) != null:
					no_duplicate = false
			if spawned_items.has(random_no):
				no_repeat = false
			if counter >= array_to_use.size():
				array_to_use = u_items		
			real.queue_free()
		spawned_items.append(random_no)
		var button = preload("res://UI/Button.tscn")
		var new_button = button.instantiate()
		child.add_child(new_button)
		new_button.intialize(array_to_use[random_no])
		new_button.position = child.position
		

func _on_skip_btn_pressed():
	game_manager.DestroyUpgradeSceneAndStartNewWave()


func _on_upgrade_btn_pressed():
	game_manager.LevelUpPlayer()
