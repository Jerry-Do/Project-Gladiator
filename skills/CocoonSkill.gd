extends State

var move_state : State
var idle_state : State
var old_armor : float
var skill_state : State
var in_state : bool = false
func _ready():
	move_state = get_parent().get_node("Move")
	idle_state = get_parent().get_node("Idle")
	
func enter() -> void:
	if parent.stats.ReturnCurrentFuel() == parent.stats.ReturnMaxFuel():
		old_armor = parent.stats.stats.Armor 
		parent.status_dictionary.stun = true
		parent.stats.SetArmor(999)
		in_state = true

	
func process_physics(delta: float):
	if in_state:
		if parent.stats.ReturnCurrentFuel() > 0 &&  Input.is_action_pressed("use_skill"):
			parent.stats.SetFuel(-delta)
			parent.fuelBar._set_fuel(parent.stats.ReturnCurrentFuel())
			parent.recharge_flag = false
			parent.stats.SetHealth(delta * 10)
			print(parent.stats.stats.Health)
		else:
			return move_state
	else:
		return move_state
		
func exit() -> void:
	if in_state:
		parent.status_dictionary.stun = false
		parent.stats.stats.Armor = old_armor
		$RechargeTimer.start()
		in_state = false

func _on_recharge_timer_timeout():
	parent.recharge_flag = true
