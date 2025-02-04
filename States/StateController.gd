extends Node

@export 
var starting_state: State

var current_state: State

func init(_parent : Node2D, movement_component):
	for child in get_children(): 
		child.parent = _parent
		child.movement_component = movement_component
		child.skill_state = get_child(3)
	change_state(starting_state)

func change_state(new_state : State) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()

func process_physics(delta : float) -> void:
	var new_state = await current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event : InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)
	
	
func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)


func _on_attack_body_entered(body):
	pass # Replace with function body.
