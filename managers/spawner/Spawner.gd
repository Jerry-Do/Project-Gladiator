extends Node2D

@onready var game_manager = get_parent()
@export var enemies : Array
@export var interval : float
@onready var spawnPoint1 = $s1
@onready var spawnPoint2 = $s2
@onready var spawnPoint3 = $s3
@onready var spawnPoint4 = $s4
@export var maxAllow : int
var maximum_reached : bool = false
var rng = RandomNumberGenerator.new()
var spawnFlag : bool = true
var spawnCount : int = 0
var currentEnemyCount : int = 0

signal WaveComplete

func _ready():
	connect("WaveComplete", game_manager.WaveComplete)
	
func _physics_process(_delta):
	if spawnFlag && spawnCount < maxAllow:
		spawnFlag = false
		$SpawnTimer.start(interval)
	if spawnCount >= maxAllow:
		$SpawnTimer.stop()

func OnEnemyKilled():
	spawnCount -= 1
	#if currentEnemyCount <= 0 && spawnCount >= maxAllow:
		#currentEnemyCount = 0
		#WaveComplete.emit()

func _on_spawn_timer_timeout():
	#clamp(GameManager.instance.currentWave , GameManager.instance.currentWave,  enemies.size() - 1)
	var randomNo = rng.randi_range(0,0)
	var randomSpawnPos = rng.randi_range(1,4)
	var spawn_point = preload("res://Enemy/EnemySpawnPoint.tscn")
	var real = spawn_point.instantiate()
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
	real.position = spawnPos
	real.rotation = rotation
	get_parent().add_child(real)
	real.Instantiate(enemies[randomNo])
	spawnCount +=  1
	spawnFlag = true
