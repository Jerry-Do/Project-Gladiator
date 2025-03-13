extends Node2D
 
@onready var spawn_points = $EnvironmentSpawnPoints
@export var environment_props : Array
@export var mega_struct_props : Array
@export var max_props : int
var spawned_props : Array
var mega_struct : MegaStruct = null
var rng = RandomNumberGenerator.new()


func _ready():
	#get_parent().connect("RoundStart", SpawnMegaStruct())
	SpawnMegaStruct()

func SpawnEnvironemnt():
	if spawned_props.size() < max_props:
		randomize()
		var random_pos : Vector2 = Vector2(randf_range(spawn_points.get_child(0).position.x, spawn_points.get_child(1).position.x), randf_range(spawn_points.get_child(0).position.y, spawn_points.get_child(2).position.y))
		var point = spawn_points.get_children()
		var random_no = randi_range(0,environment_props.size() - 1)
		var environment = load(environment_props[random_no])
		var new_prop = environment.instantiate()
		spawned_props.append(new_prop )
		new_prop.position = random_pos
		add_child(new_prop)
	
		


func _on_timer_timeout():
	SpawnEnvironemnt()

func SpawnMegaStruct():
	randomize()
	var random_no =1 #randi_range(1,4)
	if random_no == 1 && mega_struct == null:
		var random_struct = rng.randi_range(0, mega_struct_props.size()- 1)
		var structure = load(mega_struct_props[random_struct])
		var new_struct = structure.instantiate()
		var spawn_pos = get_node("MegaStruct")
		new_struct.position = Vector2(spawn_pos.global_position.x, spawn_pos.global_position.y)
		new_struct.rotation = spawn_pos.rotation
		new_struct.scale = spawn_pos.scale
		get_parent().call_deferred("add_child", new_struct)
		mega_struct = new_struct
