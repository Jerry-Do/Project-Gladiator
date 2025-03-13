extends Move

var move_state : State

var old_armor : float

var in_state : bool = false

@export var consume_rate : float 
#TODO: on evl 1, create a shockwave that pushes and stuns enemies, distance and stun duration based on charging duration 
func _ready():
	dash_state = get_parent().get_node("Dash")
	move_state = get_parent().get_node("Move")
	idle_state = get_parent().get_node("Idle")
	
func enter() -> void:
	print(parent.stats.ReturnCurrentFuel())
	if roundf(parent.stats.ReturnCurrentFuel()) == parent.stats.ReturnMaxFuel():
		old_armor = parent.stats.stats.Armor 
		parent.status_dictionary.stun = true
		parent.stats.SetArmor(999)
		in_state = true

	
func process_physics(delta: float):
	if in_state:
		if parent.stats.ReturnCurrentFuel() > 0:
			parent.stats.SetFuel(-delta * 50)
			parent.fuelBar._set_fuel(parent.stats.ReturnCurrentFuel())
			parent.recharge_flag = false
			parent.stats.SetHealth(delta * 10)
			
		else:
			if parent.get_node("Item").get_node_or_null("CoolingSystem") == null:
				parent.status_dictionary.overheat = true
			return move_state
	else:
		return move_state

func process_input(_event : InputEvent) -> State:
	if _event.is_action_pressed("use_skill"):
		return move_state
	return null
	
func exit() -> void:
	if in_state:
		parent.status_dictionary.stun = false
		parent.stats.stats.Armor = old_armor
		if parent.status_dictionary.overheat:
			$OverheatTimer.start(parent.stats.ReturnMaxFuel() / parent.stats.ReturnRechargeRate())
		$RechargeTimer.start($RechargeTimer.wait_time if parent.status_dictionary["overheat"] else $RechargeTimer.wait_time * 1.5)
		in_state = false

func _on_recharge_timer_timeout():
	parent.recharge_flag = true

func _on_overheat_timer_timeout():
	parent.status_dictionary.overheat = false
