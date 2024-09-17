extends State
class_name Move
@export
var dash_state: State
@export
var idle_state: State

var direction : Vector2



func enter() -> void:
	super()


func process_input(event : InputEvent) -> State:
	if Input.is_action_pressed("dash"):
		print("dashing")
		return dash_state
	return null
		
func process_physics(delta: float):
	
	var movement = get_movement_direction() * parent.stats.ReturnSpeed()
	if parent.recharge_flag && parent.stats.ReturnCurrentDashTime() < parent.stats.ReturnMaxDashTime():
		parent.stats.SetDashTime(delta)
		parent.fuelBar._set_fuel(parent.stats.ReturnCurrentDashTime())
	if movement.length() == 0:
		return idle_state
	parent.velocity = movement
	parent.move_and_slide()
	return null

func process_frame(delta : float):
	return null
