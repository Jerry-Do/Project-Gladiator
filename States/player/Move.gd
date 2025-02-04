extends State
class_name Move
var skill_state: State
@export var idle_state: State
@export var dash_state : State
var direction : Vector2
var usingFlag : bool = false
var turn_flag : bool
signal GetDistance(amount : int)

func enter() -> void:
	super()
	parent.animated_sprite.play("run")
	
func exit() -> void:
	parent.animated_sprite.stop()
	
func process_input(_event : InputEvent) -> State:
	
	if _event.is_action_pressed("use_skill") && parent.stats.ReturnCurrentFuel() > 0 && usingFlag == false && parent.status_dictionary["stun"] == false :
		return skill_state
	if _event.is_action_pressed("dash") && dash_state.can_dash:
		return dash_state
	return null
		
func process_physics(delta: float):
	var movement : Vector2 = get_movement_direction() * (parent.stats.ReturnSpeed() / (1 if parent.status_dictionary["slow"] == false else 2 ))
	if parent.recharge_flag && parent.stats.ReturnCurrentFuel() < parent.stats.ReturnMaxFuel() && usingFlag == false:
		usingFlag = false
		parent.stats.SetFuel(delta)
		parent.fuelBar._set_fuel(parent.stats.ReturnCurrentFuel())
	if movement.length() == 0:
		return idle_state
	parent.velocity = movement
	if parent.status_dictionary.stun == true:
		parent.velocity = Vector2.ZERO
	parent.move_and_slide()
	return null
