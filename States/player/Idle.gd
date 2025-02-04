extends State
@export
var move_state: State
@export 
var skill_state: State
@export 
var dash_state: State
func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO
	parent.animated_sprite.play("idle")
	
func exit() -> void:
	parent.animated_sprite.stop()
	
func process_input(_event : InputEvent) -> State:
	if get_movement_direction().length() != 0:
		return move_state
	if _event.is_action_pressed("use_skill") && parent.can_time_stop && parent.stats.ReturnCurrentFuel() > 0 && parent.status_dictionary["stun"] == false && parent.status_dictionary["timeStopDisable"] == false:
		return skill_state
	if _event.is_action_pressed("dash") && dash_state.can_dash:
		return dash_state
	return null
	
func process_physics(delta: float):
	if parent.recharge_flag && parent.stats.ReturnCurrentFuel() < parent.stats.ReturnMaxFuel():
		parent.stats.SetFuel(delta)
		parent.fuelBar._set_fuel(parent.stats.ReturnCurrentFuel())
		
