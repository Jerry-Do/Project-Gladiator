extends State
var dash_charges : float = 1
var dash_duration : float = 0.1
var is_dashing : bool = false
var can_dash : bool = true
var dash_speed : float = 3
var ori_velocity : Vector2
@export var move_state : State
var skill_state : State

func enter() -> void:
	can_dash = false
	is_dashing = true
	ori_velocity = parent.velocity
	if parent.velocity == Vector2.ZERO:
		parent.velocity = Vector2(-500,0) * (-1 if parent.animated_sprite.flip_h else 1)
	parent.velocity *= (dash_speed )
	
	
func exit() -> void:
	%DashCooldown.start()
	is_dashing = false
	parent.velocity = ori_velocity 
	

func process_physics(delta: float):
	if is_dashing:
		dash_duration -= delta
		parent.move_and_slide()
	if dash_duration <= 0.0:
		return move_state
	return null


func _on_dash_cooldown_timeout():
	can_dash = true
	dash_duration = 0.1
