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

var d = 0
var radius = 250
var speed = 2
func enter() -> void:
	super()
	parent.stats_dic.speed = parent.sSpeed
	parent.animation_player.play("run",-1,5)


func process_input(_event : InputEvent) -> State:
	return null
		
func process_physics(_delta: float) -> State:
	d+= _delta
	parent.global_position = Vector2(sin(d * speed) * radius, cos(d * speed) * radius)
	return 
