extends State

@export var move_state : State
@export var dead_state : State
var still_stun : bool = true
# Called when the node enters the scene tree for the first time.
func enter():
	super()
	parent.speed = 0

func exit():
	super()
	
func process_physics(_delta: float) -> State:
	if parent.status_dictionary.stun == false:
		return move_state
	if parent.health <= 0:
		return dead_state
	return null
