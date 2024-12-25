extends VBoxContainer
#@onready var player_item: PlayerItem = get_tree().get_first_node_in_group("player").get_node("Item")
var row = 5.0
var column = 5.0
func _ready():
	var counter = 0
	for i in ceil(player_item.get_child_count() / row):
		var hbox = HBoxContainer.new()
		hbox.set_name("Hbox")
		add_child(hbox)
		hbox.add_theme_constant_override("separation", 100)
		for x in 5:
			if counter < player_item.get_child_count():
				var item = preload("res://UI/ItemIcon.tscn")
				var real = item.instantiate()
				hbox.add_child(real)
				real.get_node("Container").instantiate(player_item.get_child(counter))
				counter += 1
			

		
