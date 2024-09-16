extends State
@export
var move_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0
	

func process_input(event : InputEvent) -> State:
	if get_movement_direction().length() != 0:
		return move_state
	return null
		
