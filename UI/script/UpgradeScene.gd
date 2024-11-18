extends Control
@export var c_items : Array
@export var u_items : Array
@export var r_items : Array
var array_to_use : Array
var spawned_items : Array
@onready var game_manager : GameManager = get_node("../../GameManager")
@onready var player = get_tree().get_first_node_in_group("player")
var rng_gen = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	var player_items = player.get_child(4)
	for child in get_children():
		randomize()
		var random_amount = rng_gen.randi_range(0,game_manager.currentFame) / 100.0		
		var random_noo =  randf() + random_amount
		if random_noo < 0.8:
			array_to_use = u_items
		elif random_noo < 0.95:
			array_to_use = c_items
		else:
			array_to_use = r_items
		var no_duplicate = false
		var random_no =  rng_gen.randi_range(0, array_to_use.size() - 1)
		while spawned_items.find(random_no) != -1 && no_duplicate == false: 
			no_duplicate = true
			random_no =  rng_gen .randi_range(0,array_to_use.size() - 1)
			var item = load(array_to_use[random_no])
			var real = item.instantiate()
			if real.duplicate_flag == false:
				if player_items.find_child(real.item_name):
					no_duplicate = false
			real.queue_free()
		spawned_items.append(random_no)
		var button = preload("res://UI/Button.tscn")
		var new_button = button.instantiate()
		add_child(new_button)
		new_button.intialize(array_to_use[random_no])
		new_button.position = child.position
		
