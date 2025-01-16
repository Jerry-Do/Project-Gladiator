extends State

@export var move_state : State
@export var dead_state : State
var still_stun : bool = true
# Called when the node enters the scene tree for the first time.
func enter():
	super()
	parent.stats_dic.speed = 0

func exit():
	super()
	
func process_physics(_delta: float) -> State:
	if parent.status_dictionary.stun == false:
		return move_state
	if parent.stats_dic.health <= 0:
		return dead_state
	return null
