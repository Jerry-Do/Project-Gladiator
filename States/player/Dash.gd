extends Move
@export
var move_state: State



var tmp 


@onready
var dash_timer = %DashTimer

@onready
var overheat_timer = %OverheatTimer

func enter() -> void:
	super()
	tmp = parent.stats.ReturnSpeed()
	parent.stats.SetSpeed(2500)
	usingFlag = true
	Engine.time_scale = 0.25
	
	parent.invincibleState = true
	parent.game_manager.timeSlowFlag = true
		
func process_physics(delta: float):

	if  usingFlag == true && parent.stats.ReturnCurrentDashTime() > 0 &&  Input.is_action_pressed("dash"):
		parent.stats.SetDashTime(-delta)
		parent.fuelBar._set_fuel(parent.stats.ReturnCurrentDashTime())
		parent.recharge_flag = false
	else:
		usingFlag = false
		Engine.time_scale = 1.0
		parent.stats.SetSpeed(tmp)
		dash_timer.start()
		parent.game_manager.timeSlowFlag = false
		parent.invincibleState = false
		if super.get_movement_direction().length() != 0:
			return move_state
		return idle_state
	return super(delta)


func _on_dash_timer_timeout():
	parent.recharge_flag = true # Replace with function body.


func _on_ghost_timer_timeout():
	if Input.is_action_pressed("dash") && parent.stats.ReturnCurrentDashTime() > 0:
		var this_ghost = preload("res://Sprite/Ghost.tscn").instantiate()
		get_parent().get_parent().get_parent().add_child(this_ghost)
		this_ghost.position = parent.position
		this_ghost.texture = parent.animated_sprite.sprite_frames.get_frame_texture("run",parent.animated_sprite.frame)
		this_ghost.flip_h =  parent.animated_sprite.flip_h
		this_ghost.scale = parent.animated_sprite.scale * parent.scale
		this_ghost.rotation = parent.rotation
