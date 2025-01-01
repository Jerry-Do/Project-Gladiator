extends Node2D
 
@onready var spawn_points = $EnvironmentSpawnPoints
@export var environment_props : Array
@export var mega_struct_props : Array
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	SpawnEnvironemnt()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func SpawnEnvironemnt():
	var point = spawn_points.get_children()
	var random_no = randi_range(1,2)
	for i  in point.size():
		var random_env =  rng.randi_range(0, environment_props.size()- 1)
		var environment = load(environment_props[random_env])
		var spawn_pos = point[i]
		var new_env = environment.instantiate()
		new_env.position = Vector2(spawn_pos.global_position.x, spawn_pos.global_position.y)
		new_env.rotation = spawn_pos.rotation
		new_env.scale = spawn_pos.scale
		get_parent().call_deferred("add_child", new_env)
	if random_no <= 2:
		var random_struct = rng.randi_range(0, mega_struct_props.size()- 1)
		var structure = load(mega_struct_props[random_struct])
		var new_struct = structure.instantiate()
		var spawn_pos = get_node("MegaStruct")
		new_struct.position = Vector2(spawn_pos.global_position.x, spawn_pos.global_position.y)
		new_struct.rotation = spawn_pos.rotation
		new_struct.scale = spawn_pos.scale
		get_parent().call_deferred("add_child", new_struct )
		
func DestroyEnvironment():
	for env in get_tree().get_nodes_in_group("environment"):
		env.queue_free()
