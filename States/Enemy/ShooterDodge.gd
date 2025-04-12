extends State
@export
var dead_state: State
@export
var stun_state: State
@export
var move_state : State

var old_velocity : Vector2

var is_dodging : bool = false
##Pseudo
##On reverse the velocity for a very short a mount of time, and then exit return to move state and 
## return to normal velocity
func enter() -> void:
	print("here")
	old_velocity = parent.velocity
	parent.velocity = -parent.velocity
	is_dodging = true
	%DodgeTimer.start()
	
		
func process_physics(_delta: float) -> State:
	if is_dodging == false:
		return move_state
	return null


func exit() -> void:
	parent.velocity = old_velocity


func _on_dodge_timer_timeout():
	is_dodging = false
