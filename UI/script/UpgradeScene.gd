extends Control
@export var items : Array
var spawned_items : Array
@onready var game_manager = get_node("../../GameManager")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	for child in get_children():
		#Uncomment this if you want to have unique items
		#var item_name 
		#var counter = 0
		#var dup_flag = true
		#var end_flag = false
		#var random_no
		#while dup_flag: #|| end_flag == false:
			#random_no =  RandomNumberGenerator.new().randi_range(0, items.size() - 1)
			#var pos1 = items[random_no].find("/", 10)
			#var pos2 = items[random_no].find(".", 10)
			#item_name = items[random_no].substr(pos1 + 1, pos2-(pos1 + 1))
			#counter+= 1
			#print(item_name)
			#if game_manager.duplication_array.find(item_name) == -1 && spawned_items.find(item_name) == -1:
				#dup_flag = false	
			#if items.size() == counter:
				#return
		var random_no =  RandomNumberGenerator.new().randi_range(0, items.size() - 1)
		var button = preload("res://UI/Button.tscn")
		var new_button = button.instantiate()
		add_child(new_button)
		new_button.intialize(items[random_no])
		new_button.position = child.position
		
