extends Move
@export
var move_state: State

@export
var idleState : State

var tmp 

@onready
var dash_timer = %RechargeTimer

@onready
var overheat_timer = %OverheatTimer

@onready
var ghost_timer = %GhostTimer

var in_state : bool
@export var consume_rate : float
var orginal_speed_scale = 	0
##TODO: On player lvl 6, enable perfect dodge zone
func _ready():
	dash_state = get_parent().get_node("Dash")
	move_state = get_parent().get_node("Move")
	idleState = get_parent().get_node("Idle")
	
func enter() -> void:
	super()
	parent.get_node("PerfectDodgeZone").monitoring = (true if parent.stats.stats["Level"] == 6 else false)
	if parent.item_inventory.dominant_type == "biochemical":
		$SmogTimer.start(0.03)
	if parent.can_time_stop && parent.status_dictionary["timeStopDisable"] == false:
		orginal_speed_scale = 	parent.animated_sprite.speed_scale
		if parent.perfect_dogde_collided:
			parent.perfect_time_stop_state = true
			parent.stats.SetHealth(-parent.damage_amount)
			parent.Cleanse()
			parent.perfect_dodge_timer.stop()
			print("Perfect")
		tmp = parent.stats.ReturnSpeed()
		ghost_timer.start(0.03 if parent.perfect_time_stop_state == false else 0.01)
		parent.stats.SetSpeed(2000 if parent.perfect_time_stop_state == false else 6000)
		usingFlag = true
		Engine.time_scale = 0.3 if parent.perfect_time_stop_state == false else 0.1
		parent.animated_sprite.speed_scale = parent.animated_sprite.speed_scale + 1.7 if parent.perfect_time_stop_state == false else 1.9
		parent.invincibleState = true
		parent.game_manager.timeSlowFlag = true
		in_state = true


	
func process_physics(delta: float):
	if in_state:
		if  usingFlag == true && parent.stats.ReturnCurrentFuel() > 0 && parent.status_dictionary["stun"] == false && parent.status_dictionary["timeStopDisable"] == false:
			parent.stats.SetFuel(-delta * consume_rate)
			parent.fuelBar._set_fuel(parent.stats.ReturnCurrentFuel())
			parent.recharge_flag = false
		else:
			if parent.get_node("Item").get_node_or_null("CoolingSystem") == null:
				parent.status_dictionary.overheat = true
			if super.get_movement_direction().length() != 0:
					return move_state
			return idleState
	return super(delta)

func process_input(_event : InputEvent) -> State:
	if _event.is_action_pressed("dash") && parent.dash_charge > 0:
		get_parent().previous_state = self
		return dash_state
	if _event.is_action_pressed("use_skill"):
		return move_state
	return null
	

func _on_ghost_timer_timeout():
	if in_state && parent.stats.ReturnCurrentFuel() > 0 && usingFlag == true:
		var this_ghost = preload("res://Sprite/Ghost.tscn").instantiate()
		parent.get_parent().add_child(this_ghost)
		this_ghost.position = parent.position
		this_ghost.texture = parent.animated_sprite.sprite_frames.get_frame_texture("run",parent.animated_sprite.frame)
		this_ghost.flip_h =  parent.animated_sprite.flip_h
		this_ghost.scale = parent.animated_sprite.scale * parent.scale
		this_ghost.rotation = parent.rotation

func exit():
	if in_state:
		super()
		parent.perfect_time_stop_state = false
		parent.perfect_dodge_timer.start()
		ghost_timer.stop()
		$SmogTimer.stop()
		usingFlag = false
		Engine.time_scale = 1.0
		parent.stats.SetSpeed(tmp)
		$RechargeTimer.start($RechargeTimer.wait_time if parent.status_dictionary["overheat"] else $RechargeTimer.wait_time * 1.5)
		if parent.status_dictionary.overheat:
			$OverheatTimer.start(parent.stats.ReturnMaxFuel() / parent.stats.ReturnRechargeRate())
		parent.game_manager.timeSlowFlag = false
		parent.invincibleState = false
		parent.animated_sprite.speed_scale = orginal_speed_scale


func _on_time_stop_recharge_timer_timeout():
	parent.recharge_flag = true




func _on_overheat_timer_timeout():
	parent.status_dictionary.overheat = false


func _on_smog_timer_timeout():
	var smog = preload("res://skills/etc/Smog.tscn").instantiate()
	parent.get_parent().add_child(smog)
	smog.position = parent.position
	smog.scale = parent.animated_sprite.scale * parent.scale
	smog.rotation = parent.rotation
