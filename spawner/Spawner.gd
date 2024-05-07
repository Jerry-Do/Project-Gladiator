extends Node2D


@export var enemies : Array
@export var interval : float
@onready var spawnPoint1 = $s1
@onready var spawnPoint2 = $s2
@onready var spawnPoint3 = $s3
@onready var spawnPoint4 = $s4
@export var maxAllow : int
var rng = RandomNumberGenerator.new()
var spawnFlag : bool = true
var spawnCount : int = 0

func _physics_process(delta):
	if spawnFlag:
		spawnFlag = false
		$SpawnTimer.start(interval)
		spawnCount +=  1
	if spawnCount >= maxAllow:
		spawnFlag = false
	else:
		spawnFlag = true
		
	
	
func OnEnemyKilled():
	spawnCount -= 1
	if spawnCount <= 0:
		spawnCount = 0


func _on_spawn_timer_timeout():
	var randomNo = rng.randi_range(0, enemies.size() - 1)
	var randomSpawnPos = rng.randi_range(1,4)
	var enemy = load(enemies[randomNo])
	var newEnemy = enemy.instantiate()
	var spawnPos : Vector2 = Vector2.ZERO
	match randomSpawnPos:
		1:
			spawnPos = spawnPoint1.global_position

		2:
			spawnPos = spawnPoint2.global_position

		3:
			spawnPos = spawnPoint3.global_position

		4:
			spawnPos = spawnPoint4.global_position
		
	
	newEnemy.position = spawnPos
	newEnemy.rotation = rotation
	get_parent().add_child(newEnemy)
	spawnFlag = true
