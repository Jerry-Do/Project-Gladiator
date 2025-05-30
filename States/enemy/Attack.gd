extends State
class_name Attack
@export 
var move_state : State

@export 
var dead_state: State

@export
var stun_state: State

func enter() -> void:
	super()
	parent.inRange = true
	parent.stats_dic.speed = 0
	var wind_up_time = parent.stats_dic["windup_time"] * (parent.amount_dic.buff_dic["atk_speed"] if parent.buff_dictionary["atk_speed"] else 1)
	wind_up_time = wind_up_time * ((1.0 + parent.amount_dic.debuff_dic["toxin"]) if parent.status_dictionary["toxin"] else 1)
	%AttackWindup.start(wind_up_time)


func process_physics(_delta: float) -> State:
	if parent.stats_dic.health <= 0:
		return dead_state
	if parent.inRange == false:
		return move_state
	return null
	
func _on_attack_windup_timeout():
	if parent.inRange:
		parent.Attack()


func _on_attack_range_area_exited(area):
	if area.has_method("TakingDamageForPlayer") ||  (area.has_method("DestroyProp") && parent.name != "Disabler") :
		parent.PlayerLeft()
	
