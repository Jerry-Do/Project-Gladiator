extends Node2D

func _enter_tree():
	var PLAYER = preload("res://Player/Player.tscn")
	var newPlayer= PLAYER.instantiate()
	newPlayer.position = position
	newPlayer.rotation = rotation
	get_node("/root/Game/Level").call_deferred("add_child", newPlayer)
