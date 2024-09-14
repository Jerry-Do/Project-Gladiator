extends State
@export
var move_state: State
@export
var idle_state: State
var can_dash : bool = true
var direction : Vector2

@onready
var dash_timer = %DashTimer
func enter() -> void:
	super()


func process_input(event : InputEvent) -> State:
	if Input.get_vector("move_left", "move_right", "move_up", "move_down").length() != 0:
		return move_state
	elif Input.get_vector("move_left", "move_right", "move_up", "move_down").length() == 0:
		return idle_state
	return null
		
func process_physics(delta: float):
	if can_dash:
		parent.velocity *= 50
		can_dash = false
		dash_timer.start(1)
		
		parent.move_and_slide()
	return null


func _on_dash_timer_timeout():
	can_dash = true # Replace with function body.
