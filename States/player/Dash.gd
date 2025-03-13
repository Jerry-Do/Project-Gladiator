extends State
@export var move_state : State
@onready var gunslinger = get_node_or_null("GunslingerSkill") 
@onready var front_hitbox : Area2D = %Front
@export var dash_state : State
var dash_duration : float = 0.1
var is_dashing : bool = false
var dash_speed : float = 3
var ori_velocity : Vector2
var skill_state : State
##TODO: implement double dash, make when finsihed recharge timer two charges is added instead of one
func enter() -> void:
	
	if gunslinger != null:
		if gunslinger.in_state && parent.stats["Level"] == 6:
			parent.just_dash = true
	is_dashing = true
	ori_velocity = parent.velocity
	if parent.velocity == Vector2.ZERO:
		parent.velocity = Vector2(-500,0) * (-1 if parent.animated_sprite.flip_h else 1)
	parent.velocity *= (dash_speed )
	front_hitbox.monitoring = false
	
func process_physics(delta: float):
	if is_dashing:
		dash_duration -= delta
		parent.move_and_slide()
	if dash_duration <= 0.0:
		return get_parent().previous_state
	
	return null
		
func exit() -> void:
	dash_duration = 0.1
	if %DashCooldown.is_stopped():
		%DashCooldown.start(parent.stats.ReturnDashCooldown())
	parent.dash_charges -= 1
	is_dashing = false
	parent.velocity = ori_velocity 
	front_hitbox.monitoring = true




func _on_dash_cooldown_timeout():
	dash_duration = 0.1
	parent.dash_charges = clampi(parent.dash_charges + 2,0,2)

func ResetDash():
	if gunslinger != null:
		if gunslinger.in_state && parent.stats["Level"] == 12:
			parent.dash_charges += 1
			dash_duration = 0.1
