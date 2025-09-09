extends State
@export var move_state : State
@onready var gunslinger = get_node_or_null("GunslingerSkill") 
@onready var front_hitbox : Area2D = %Front
@export var dash_state : State
var dash_duration : float = 0.2
var is_dashing : bool = false
var dash_speed : float = 3
var ori_velocity : Vector2
var skill_state : State = null
##TODO: implement double dash, make when finsihed recharge timer two charges is added instead of one

func enter() -> void:
	if gunslinger != null:
		if gunslinger.in_state && parent.stats["Level"] == 6:
			parent.just_dash = true
	is_dashing = true
	ori_velocity = parent.velocity
	if parent.velocity == Vector2.ZERO:
		parent.velocity = Vector2(-500,0) * (-1 if parent.animated_sprite.flip_h else 1)
	parent.velocity *= (0.75 if get_parent().previous_state != null && get_parent().previous_state.name == "TimeSlow" else dash_speed)
	if get_parent().previous_state != null && get_parent().previous_state.name == "TimeSlow":
		$GhostTimer.start(0.03 if parent.perfect_time_stop_state == false else 0.01)
	front_hitbox.monitoring = false
	parent.invincibleState = true
	
func process_physics(delta: float):
	if is_dashing:
		dash_duration -= delta
		parent.move_and_slide()
	if dash_duration <= 0.0:
		return get_parent().previous_state
	
	return null
		
func exit() -> void:
	dash_duration = 0.1
	if !$GhostTimer.is_stopped():
		$GhostTimer.stop()
	if %DashCooldown.is_stopped():
		%DashCooldown.start(parent.stats.ReturnDashCooldown())
	parent.dash_charges -= 1
	is_dashing = false
	parent.velocity = ori_velocity 
	front_hitbox.monitoring = true
	parent.invincibleState = false




func _on_dash_cooldown_timeout():
	dash_duration = 0.1
	parent.dash_charges = clampi(parent.dash_charges + 2,0,2)

func ResetDash():
	pass


func _on_ghost_timer_timeout():
	var this_ghost = preload("res://Sprite/Ghost.tscn").instantiate()
	parent.get_parent().add_child(this_ghost)
	this_ghost.position = parent.position
	this_ghost.texture = parent.animated_sprite.sprite_frames.get_frame_texture("run",parent.animated_sprite.frame)
	this_ghost.flip_h =  parent.animated_sprite.flip_h
	this_ghost.scale = parent.animated_sprite.scale * parent.scale
	this_ghost.rotation = parent.rotation
