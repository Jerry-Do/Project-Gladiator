extends State
@export
var dash_state: State
@export
var idle_state: State

var direction : Vector2

func enter() -> void:
	super()


func process_input(event : InputEvent) -> State:
	if Input.is_action_just_pressed("dash"):
		return dash_state
	return null
		
func process_physics(delta: float):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var movement = direction * parent.stats.ReturnSpeed()
	
	if movement.length() == 0:
		return idle_state
	parent.velocity = movement
	parent.move_and_slide()
	
	
	
	return null
