class_name State
extends Node

@export 
var animation_name : String


var parent : Node2D

var movement_component

func enter() -> void:
	parent = get_parent().get_parent()
func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

func get_movement_direction() -> Vector2:
	return movement_component.get_movement_direction()
