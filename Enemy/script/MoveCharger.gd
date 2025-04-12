extends State
class_name MoveCharger
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
	parent.animation_player.play("run",-1,5)


func process_input(_event : InputEvent) -> State:
	return null
		
func process_physics(_delta: float) -> State:
	if parent.stats_dic.health <= 0:
		return dead_state
	if parent.player != null:
		if  parent.player.is_invisible == false && parent.status_dictionary.stun == false:
			direction = (parent.player.position - parent.position).normalized()
			parent.velocity = direction * (parent.stats_dic.speed * 0.5 if parent.status_dictionary.slow else parent.stats_dic.speed)
			if parent.softCollision.IsColliding():
				parent.velocity += parent.softCollision.GetPushVector() * _delta * 6500	
			parent.velocity = parent.velocity if parent.status_dictionary.slow == false else parent.velocity / 2
			parent.move_and_slide()
		else:
			parent.position = parent.position
	return null

func process_frame(_delta : float) -> State:
	return null


func _on_turn_timer_timeout():
	if parent.player != null:
		if (parent.player.position - parent.position).sign().x != parent.scale.y && parent.player.is_invisible == false:
			parent.set_scale(Vector2(1,parent.scale.y * -1))
			parent.set_rotation_degrees( parent.get_rotation_degrees() + 180 * -1)


func _on_attack_area_entered(area):
	if area.has_method("SetStatusPlayer"):
		parent.status_dictionary.stun = true
		%Attack.get_child(0).call_deferred("set_disabled", true)
		area.SetStatusPlayer("slow" if parent.evo_flag == false else "stun", 2)
		area.TakingDamageForPlayer(-parent.stats_dic.damage, true if area.get_name() == "Back" else false, parent)
		parent.game_manager.AdjustFame(-(parent.game_manager.currentFame * 0.10))
		%StunTimer.start()
	if area.has_method("DestroyProp"):
		area.call_deferred("DestroyProp")
		parent.status_dictionary.stun = true
		%Attack.get_child(0).call_deferred("set_disabled", true)
		%StunTimer.start()




func _on_stun_timer_timeout():
	parent.status_dictionary.stun = false
	%Attack.get_child(0).disabled = false

	



	
