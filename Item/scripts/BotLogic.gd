extends CharacterBody2D
##TODO
##Add a level up mechanic
##After killing a certain amount of enemy, the bot will level up ang get new attacks

@export
var damage = 0
@onready
var nav_agent = $NavigationAgent2D 
@export
var speed = 100
@onready var player = get_parent()

var shoot_flag = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):	
	$Marker2D.look_at(get_global_mouse_position())
	var direction = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = direction * speed
	move_and_slide()

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
