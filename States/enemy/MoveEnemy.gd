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
var is_dodging 
func enter() -> void:
	super()
	parent.stats_dic.speed = parent.sSpeed
	parent.animation_player.play("run",-1,5)


func process_input(_event : InputEvent) -> State:
	return null
		
func process_physics(_delta: float) -> State:
	if parent.stats_dic.health <= 0:
		return dead_state
	if parent.status_dictionary.stun:
		return stun_state
	if parent.player != null:
		if  parent.player.is_invisible == false:
			parent.stats_dic.speed = parent.sSpeed * (parent.amount_dic.buff_dic["speed"] if parent.buff_dictionary["speed"] == true else 1)
			var direction = (parent.player.position - parent.position).normalized()
			if parent.thingHitBox != null:
				return attack_state
			
			parent.velocity = direction * (parent.stats_dic.speed * parent.amount_dic.debuff_dic["slow"] if parent.status_dictionary.slow else parent.stats_dic.speed)
			if parent.softCollision.IsColliding():
				parent.velocity += parent.softCollision.GetPushVector() * _delta * 6500	
			parent.move_and_slide()
		else:
			parent.stats_dic.speed = 0
	return null
		
func _on_attack_range_area_entered(area):
	if area.has_method("TakingDamageForPlayer") || (area.has_method("DestroyProp") && parent.name != "Disabler") :
		parent.thingHitBox = area


func _on_turn_timer_timeout():
	if parent.player != null:
		if (parent.player.global_position - parent.sprite.global_position).sign().x != parent.sprite.scale.sign().y && parent.player.is_invisible == false:
			parent.sprite.set_scale(Vector2(parent.sprite.scale.x,parent.sprite.scale.y * -1))
			parent.sprite.set_rotation_degrees( parent.sprite.get_rotation_degrees() + 180 * -1)
