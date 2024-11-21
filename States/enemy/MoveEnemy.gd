extends State
@export
var dead_state: State
@export
var stun_state: State
@export
var move_state : State
@export
var attack_state : State
var direction : Vector2
var turn_flag : bool = false
func enter() -> void:
	super()
	parent.speed = parent.sSpeed
	parent.animation_player.play("run",-1,5)


func process_input(_event : InputEvent) -> State:
	return null
		
func process_physics(_delta: float) -> State:
	if parent.health <= 0:
		return dead_state
	if parent.status_dictionary.stun:
		return stun_state
	if  parent.player.is_invisible == false:
		parent.speed = parent.sSpeed
		var direction = (parent.player.position - parent.position).normalized()
		if parent.playerHitBox != null:
			return attack_state
		parent.velocity = direction * parent.speed 
		if parent.softCollision.IsColliding():
			parent.velocity += parent.softCollision.GetPushVector() * _delta * 6500	
		parent.velocity = parent.velocity if parent.status_dictionary.slow == false else parent.velocity / 2
		parent.move_and_slide()
	else:
		parent.speed = 0
	return null

func process_frame(_delta : float) -> State:
	return null

		


func _on_attack_range_area_entered(area):
	if area.has_method("TakingDamageForPlayer"):
		parent.playerHitBox = area


func _on_turn_timer_timeout():
	if (parent.player.position - parent.position).sign().x != parent.scale.y && parent.player.is_invisible == false:
		parent.set_scale(Vector2(1,parent.scale.y * -1))
		parent.set_rotation_degrees( parent.get_rotation_degrees() + 180 * -1)
