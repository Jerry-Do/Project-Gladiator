extends State
@export
var move_state: State

func enter() -> void:
	super()
	

func process_physics(delta) -> State:
	return move_state

		
