class_name State
extends Node

@export 
var animation_name : String

@export
var movement_speed : float = 800

var parent : Player

func enter() -> void:
	#parent.animations.play(animation_name)
	parent = get_parent().get_parent()

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
