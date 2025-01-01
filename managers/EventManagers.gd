extends Node

@export var no_round_to_activate = 0
var game_manager : GameManager = null
var event_dict : Dictionary = {
	"frenzy_hormone" : false,
	"orbital_strike" : false,
	
}


func _ready():
	game_manager = get_parent()
	game_manager.connect("RoundStart", self.CreateEvent)

func CreateEvent():
	if game_manager.currentWave >= no_round_to_activate:
		for i in event_dict:
			event_dict[i] = false
		var randon_no = randi_range(1,4)
		if randon_no == 4:
			var event = randi_range(1,event_dict.size())
			match event:
				1:
					event_dict.frenzy_hormone = true
				2:
					event_dict.orbital_strike = true
