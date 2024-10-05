extends State
class_name Move
@export
var dash_state: State
@export
var idle_state: State

var direction : Vector2

var usingFlag : bool = false

var turn_flag : bool
func enter() -> void:
	super()
	parent.animated_sprite.play("run")
	
func exit() -> void:
	parent.animated_sprite.stop()
	
func process_input(_event : InputEvent) -> State:
	if Input.is_action_pressed("dash") && parent.stats.ReturnCurrentDashTime() > 0 && usingFlag == false:
		return dash_state
	return null
		
func process_physics(delta: float):
	var movement = get_movement_direction() * parent.stats.ReturnSpeed()
	if parent.recharge_flag && parent.stats.ReturnCurrentDashTime() < parent.stats.ReturnMaxDashTime() && usingFlag == false:
		usingFlag = false
		parent.stats.SetDashTime(delta)
		parent.fuelBar._set_fuel(parent.stats.ReturnCurrentDashTime())
	if movement.length() == 0:
		return idle_state
	parent.velocity = movement
	parent.move_and_slide()
	return null
