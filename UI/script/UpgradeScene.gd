extends Control
@export var items : Array
var spawned_items : Array
@onready var game_manager = get_node("../../GameManager")
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		var random_no =  RandomNumberGenerator.new().randi_range(0, items.size() - 1)
		while spawned_items.find(random_no) != -1:
			random_no =  RandomNumberGenerator.new().randi_range(0, items.size() - 1)
		spawned_items.append(random_no)
		var button = preload("res://UI/Button.tscn")
		var new_button = button.instantiate()
		add_child(new_button)
		new_button.intialize(items[random_no])
		new_button.position = child.position
		
