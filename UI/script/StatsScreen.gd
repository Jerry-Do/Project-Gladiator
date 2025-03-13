extends VBoxContainer

@onready var player_stats = get_tree().get_first_node_in_group("player").stats
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_child_count():
		if get_child(i).name == "Health" :
			get_child(i).text += " " + str(player_stats.maxHealth)
		else:
			get_child(i).text += " " + str(player_stats.stats[get_child(i).name])
		
