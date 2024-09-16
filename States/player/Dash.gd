extends Move
@export
var move_state: State

var can_dash : bool = true


@onready
var dash_timer = %DashTimer
func enter() -> void:
	super()


func process_input(event : InputEvent) -> State:
	return null
		
func process_physics(delta: float):
	if can_dash:
		parent.invincibleState = true
		parent.velocity *= 50
		can_dash = false
		dash_timer.start(1)
		parent.move_and_slide()
		
	if movement_component.get_movement_direction().length() != 0:
		parent.invincibleState = false
		return move_state
	return idle_state


func _on_dash_timer_timeout():
	
	can_dash = true # Replace with function body.
