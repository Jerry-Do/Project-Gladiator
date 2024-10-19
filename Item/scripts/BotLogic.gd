extends CharacterBody2D

@export
var damage = 0
@onready
var nav_agent = $NavigationAgent2D 
@export
var speed = 100
@onready var player = get_parent()

var shoot_flag = true

func MakePath():
	nav_agent.target_position = player.global_position


func _on_timer_timeout():
	MakePath()

func _unhandled_input(event):
	if event.is_action_pressed("left_click"):			
		var BULLET = preload("res://Weapon/bullet/BotBullet.tscn")
		var new_bullet = BULLET.instantiate()
		new_bullet.position = global_position
		new_bullet.rotation = $Marker2D.global_rotation
		call_deferred("add_child", new_bullet)
		shoot_flag = false
		$Downtime.start()

func _on_downtime_timeout():
	shoot_flag = true
