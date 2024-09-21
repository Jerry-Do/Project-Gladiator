extends Control
@export var items : Array
@export var spawn_pos : Array
# Called when the node enters the scene tree for the first time.
func _ready():
	var random_no =  RandomNumberGenerator.new().randi_range(0, items.size() - 1)
	var item = load(items[random_no])
	for child in get_children():
		var button = preload("res://UI/Button.tscn")
		var new_button = button.instantiate()
		add_child(new_button)
		new_button.position = child.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
