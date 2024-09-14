extends State
@export
var move_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0
	

func process_input(event : InputEvent) -> State:
	if Input.get_vector("move_left", "move_right", "move_up", "move_down").length() != 0:
		return move_state
	return null
		
