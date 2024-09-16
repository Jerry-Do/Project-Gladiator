extends State
class_name Move
@export
var dash_state: State
@export
var idle_state: State

var direction : Vector2

var speed_fuel

func enter() -> void:
	super()


func process_input(event : InputEvent) -> State:
	if Input.is_action_pressed("dash"):
		return dash_state
	return null
		
func process_physics(delta: float):
	var movement = get_movement_direction() * parent.stats.ReturnSpeed()
	if movement.length() == 0:
		return idle_state
	parent.velocity = movement
	parent.move_and_slide()
	return null

func process_frame(delta : float):
	return null
