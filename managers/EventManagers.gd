extends Node
class_name EventManager
@export var no_round_to_activate = 0
@export var orbital_strike_wait_time : float = 0
var game_manager : GameManager = null
var event_dict : Dictionary[String,bool] = {
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
		var randon_no = randi_range(1,2)
		if randon_no == 2:
			var event = randi_range(1,1)
			match event:
				0:
					event_dict.frenzy_hormone = true
					GameManager.instance.ui.ShowEvent(0)
				1:
					event_dict.orbital_strike = true
					$EventTimer.start(orbital_strike_wait_time)
					GameManager.instance.ui.ShowEvent(1)

		


func _on_timer_timeout():
	if event_dict.orbital_strike:
		var orbital_strike = preload("res://events/OrbitalStrike.tscn")
		var real = orbital_strike.instantiate()
		var player = get_tree().get_first_node_in_group("player")
		var random_no = randi_range(-200, 200)
		var pos_x = clamp(player.position.x + random_no, -76, 1413)
		var pos_y = clamp(player.position.y + random_no, -93, 657)
		real.position = Vector2( pos_x,  pos_y)
		get_parent().get_parent().add_child(real)
