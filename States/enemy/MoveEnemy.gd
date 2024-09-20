extends State
@export
var dead_state: State
@export
var stun_state: State
@export
var move_state : State

var direction : Vector2

func enter() -> void:
	super()


func process_input(event : InputEvent) -> State:
	return null
		
func process_physics(delta: float) -> State:
	MakePath()
	direction = parent.to_local(parent.navAgent.get_next_path_position()).normalized()
	parent.velocity = direction * parent.speed
	if parent.softCollision.IsColliding():
		parent.velocity = parent.softCollision.GetPushVector() * 100
	if parent.health <= 0:
		return dead_state
	parent.move_and_slide()
	return null

func process_frame(delta : float) -> State:
	return null

func MakePath():
	if parent.player != null:
		parent.navAgent.target_position = parent.player.global_position
		parent.sprite.play("run")
		if(parent.player.position.x - parent.position.x) < 0:
			parent.sprite.flip_h = true
		else:
			parent.sprite.flip_h = false
	else:
		parent.sprite.play("idle")
