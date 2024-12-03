extends Node2D
 
@onready var spawn_points = $EnvironmentSpawnPoints
@export var environment_props : Array
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	SpawnEnvironemnt()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func SpawnEnvironemnt():
	var point = spawn_points.get_children()
	for i  in point.size():
		var random_env =  rng.randi_range(0, environment_props.size()- 1)
		var environment = load(environment_props[random_env])
		var spawn_pos = point[i]
		var new_env = environment.instantiate()
		new_env.position = Vector2(spawn_pos.global_position.x, spawn_pos.global_position.y)
		new_env.rotation = spawn_pos.rotation
		new_env.scale = spawn_pos.scale
		get_parent().call_deferred("add_child", new_env)

func DestroyEnvironment():
	for env in get_tree().get_nodes_in_group("environment"):
		env.queue_free()
