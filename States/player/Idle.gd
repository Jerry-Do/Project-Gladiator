extends State
@export
var move_state: State

func enter() -> void:
	super()
	parent.animated_sprite.play("idle")
	parent.velocity.x = 0
	
func exit() -> void:
	parent.animated_sprite.stop()
	
func process_input(_event : InputEvent) -> State:
	if get_movement_direction().length() != 0:
		return move_state
	return null
	
func process_physics(delta: float):
	if parent.recharge_flag && parent.stats.ReturnCurrentDashTime() < parent.stats.ReturnMaxDashTime():
		parent.stats.SetDashTime(delta)
		parent.fuelBar._set_fuel(parent.stats.ReturnCurrentDashTime())
		
