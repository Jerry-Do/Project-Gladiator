extends CharacterBody2D
class_name Enemy
var health: int
var speed: float
var damage: float
var fameAmount : int
var chase: bool
@onready var player = get_node("../Player")
@onready var navAgent = $NavigationAgent2D 
@onready var softCollision = $SoftCollision
@onready var spawner = get_node("../Spawner")
func _init(health: int, speed: float, damage: float, fame : int):
	self.health = health
	self.speed = speed
	self.damage = damage
	self.fameAmount = fame

func _physics_process(delta: float):
	
	var direction = to_local(navAgent.get_next_path_position()).normalized()
	velocity = direction * speed
	if softCollision.IsColliding():
		velocity += softCollision.GetPushVector() * 10000 * delta	
	move_and_slide()
	if health <= 0:
		var level = get_node("/root/Game/Level")
		level.AdjustFame(fameAmount)
		level.IncreaseKillCount()
		spawner.OnEnemyKilled()
		queue_free()

func MakePath():
	if player != null:
		navAgent.target_position = player.global_position
		$AnimatedSprite2D.play("run")
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
	
func take_damage(amount : int):
	health -= amount
	



func _on_timer_timeout():
	MakePath()

func ReturnFame():
	return fameAmount
