extends Move
@export
var move_state: State

var tmp 

@onready
var dash_timer = %DashTimer

@onready
var overheat_timer = %OverheatTimer

@onready
var ghost_timer = %GhostTimer

func enter() -> void:
	super()
	if parent.perfect_dogde_collided:
		parent.perfect_time_stop_state = true
		parent.perfect_dodge_timer.stop()
	tmp = parent.stats.ReturnSpeed()
	ghost_timer.start(0.05 if parent.perfect_time_stop_state == false else 0.01)
	parent.stats.SetSpeed(1500 if parent.perfect_time_stop_state == false else 6000)
	usingFlag = true
	Engine.time_scale = 0.50 if parent.perfect_time_stop_state == false else 0.1
	parent.invincibleState = true
	parent.game_manager.timeSlowFlag = true


	
func process_physics(delta: float):
	if  usingFlag == true && parent.stats.ReturnCurrentDashTime() > 0 &&  Input.is_action_pressed("dash") && parent.status_dictionary["Stun"] == false && parent.status_dictionary["TimeStopDisable"] == false:
		parent.stats.SetDashTime(-delta * (1 if parent.perfect_time_stop_state == false else 2))
		parent.fuelBar._set_fuel(parent.stats.ReturnCurrentDashTime())
		parent.recharge_flag = false
	else:
		if super.get_movement_direction().length() != 0:
				return move_state
		return idle_state
	return super(delta)


func _on_dash_timer_timeout():
	parent.recharge_flag = true # Replace with function body.


func _on_ghost_timer_timeout():
	if Input.is_action_pressed("dash") && parent.stats.ReturnCurrentDashTime() > 0 && usingFlag == true:
		var this_ghost = preload("res://Sprite/Ghost.tscn").instantiate()
		get_parent().get_parent().get_parent().add_child(this_ghost)
		this_ghost.position = parent.position
		this_ghost.texture = parent.animated_sprite.sprite_frames.get_frame_texture("run",parent.animated_sprite.frame)
		this_ghost.flip_h =  parent.animated_sprite.flip_h
		this_ghost.scale = parent.animated_sprite.scale * parent.scale
		this_ghost.rotation = parent.rotation

func exit():
	super()
	parent.perfect_time_stop_state = false
	parent.perfect_dodge_timer.start()
	
	usingFlag = false
	Engine.time_scale = 1.0
	parent.stats.SetSpeed(tmp)
	dash_timer.start(parent.stats.ReturnChargeTime())
	parent.game_manager.timeSlowFlag = false
	parent.invincibleState = false
