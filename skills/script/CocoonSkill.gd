extends Move

var move_state : State

var old_armor : float

var in_state : bool = false

var enemies_in_range : Array

var tick : float = 0

var tick_threshhold : float = 0.5
@export var regen_amount : float = 0
@export var consume_rate : float = 0
@export var damage_amount : float = 0
#TODO: on evl 1,
func _ready():
	dash_state = get_parent().get_node("Dash")
	move_state = get_parent().get_node("Move")
	idle_state = get_parent().get_node("Idle")
	
func enter() -> void:
	#if roundf(parent.stats.ReturnCurrentFuel()) == parent.stats.ReturnMaxFuel():
	old_armor = parent.stats.stats.Armor 
	parent.status_dictionary.stun = true
	parent.stats.SetArmor(999)
	in_state = true
	if parent.item_inventory.dominant_type == "biochemical":
		$RootZone.global_position = parent.global_position
		$RootZone.monitoring = true
		$RootZone.visible = true
		regen_amount = 0
	elif parent.item_inventory.dominant_type == "tech":
		$Explosion.global_position = parent.global_position
		
func process_physics(delta: float):
	if in_state:
		if parent.stats.ReturnCurrentFuel() > 0 :
			tick += delta
			parent.stats.SetFuel(-delta * 50)
			parent.fuelBar._set_fuel(parent.stats.ReturnCurrentFuel())
			parent.recharge_flag = false	
			if parent.item_inventory.dominant_type == "biochemical" && tick >= tick_threshhold:
				for i in enemies_in_range:
					i.TakingDamageForOther(damage_amount, false, "biochemical", false)
					parent.stats.SetHealth(damage_amount)
				tick = 0
			else:
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
		if parent.item_inventory.dominant_type == "biochemical":
			$RootZone.monitoring = false
			$RootZone.visible = false
		elif parent.item_inventory.dominant_type == "tech":
			$Explosion.PlayAnimation()
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

#
func _on_root_zone_area_entered(area):
	if area.has_method("TakingDamageForOther"):
		enemies_in_range.append(area)


func _on_explosion_area_entered(area):
	if area.has_method("SetStatus") && area.get_parent().name != "Player" :
		area.SetStatus("stun", 3)
