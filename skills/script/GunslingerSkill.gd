extends Move


@export var consume_rate : float 
var move_state : State

var old_rate_of_fire: float
var old_reload_time : float 

var in_state : bool = false
##TODO On evolve 1, after dashing in this state the next bullet does increase dmg, 
##on evolve 2 killing an enemy in this state refresh dodge cooldown
func _ready():
	dash_state = get_parent().get_node("Dash")
	move_state = get_parent().get_node("Move")
	idle_state = get_parent().get_node("Idle")
	
func enter() -> void:
	if parent.currentWeapon != null:
		old_rate_of_fire = parent.currentWeapon.rateOfFire
		old_reload_time = parent.currentWeapon.reloadTime
		parent.currentWeapon.reloadTime = 0.25
		parent.currentWeapon.rateOfFire = 0.25
		in_state = true
		print(parent.velocity)

	
func process_physics(delta: float):
	super(delta)
	if in_state:
		if parent.stats.ReturnCurrentFuel() > 0:
			parent.stats.SetFuel(-delta * consume_rate)
			parent.fuelBar._set_fuel(parent.stats.ReturnCurrentFuel())
			parent.recharge_flag = false
		elif parent.item_inventory.dominant_type == "biochemical" && parent.stats.ReturnCurrentFuel() <= 0 && parent.stats.ReturnCurrentHealth() > 1:
			parent.stats.SetHealth(-delta * (consume_rate)/2.0)
			
		else:
			if parent.get_node("Item").get_node_or_null("CoolingSystem") == null:
				parent.status_dictionary.overheat = true
			return move_state
	else:
		return move_state

func process_input(_event : InputEvent) -> State:
	if _event.is_action_pressed("dash") && dash_state.can_dash:
		get_parent().previous_state = self
		return dash_state
	if _event.is_action_pressed("use_skill"):
		return idle_state
	if _event.is_action_released("left_click"):
		parent.currentWeapon.shootFlag = true
		if parent.currentWeapon && parent.status_dictionary.stun == false && parent.currentWeapon.reloadFlag == false:
			parent.currentWeapon.shoot()	
			parent.game_manager.UpdateAmmo(parent.currentWeapon.currentAmmo)
	return null
	
func exit() -> void:
	if in_state:
		$RechargeTimer.start($RechargeTimer.wait_time if parent.status_dictionary["overheat"] else $RechargeTimer.wait_time * 1.5)
		in_state = false
		if parent.status_dictionary.overheat:
			$%OverheatTimer.start(parent.stats.ReturnMaxFuel() / parent.stats.ReturnRechargeRate())
		parent.currentWeapon.rateOfFire = old_rate_of_fire 
		parent.currentWeapon.reloadTime = old_reload_time

func _on_recharge_timer_timeout():
	parent.recharge_flag = true


func _on_overheat_timer_timeout():
	parent.status_dictionary.overheat = false
