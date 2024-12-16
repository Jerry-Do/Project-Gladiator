extends Control

@onready var player_item: PlayerItem = get_tree().get_first_node_in_group("player").get_node("Item")
@onready var player_stats = get_tree().get_first_node_in_group("player").stats
@onready var grid_container = %GridContainer
@onready var vbox = %VBoxContainer
@onready var biochem_label = $Biochemical
@onready var tech_label = $Tech
var row = 5.0

func _ready():
	var counter = 0
	for i in ceil(player_item.get_child_count() / row):
		for x in grid_container.columns:
			if counter < player_item.get_child_count():
				var item = preload("res://UI/ItemIcon.tscn")
				var real = item.instantiate()
				grid_container.add_child(real)
				real.get_node("Container").instantiate(player_item.get_child(counter))
				counter += 1
	for i in vbox.get_child_count():
		if vbox.get_child(i).name == "Health" :
			vbox.get_child(i).text += " " + str(player_stats.maxHealth)
		elif vbox.get_child(i).name == "Dash_Time":
			vbox.get_child(i).text += " " + str(player_stats.maxDashTime)
		else:
			vbox.get_child(i).text += " " + str(player_stats.stats[vbox.get_child(i).name])
	tech_label.text = "Tech: " + str(player_item.item_types.tech)
	biochem_label.text = "Biochemical: " + str(player_item.item_types.biochemical)
