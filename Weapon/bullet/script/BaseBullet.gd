extends Area2D
class_name BaseBullet
var travelled_dist = 0
var damage : int
var speed : int
var crit_chance 
var leech_seed : bool
var adrenaline_rush : bool
const RANGE = 1500
@onready var game_manager = get_tree().get_first_node_in_group("GameManager")
@onready var sprite = $Bullet
@onready var player : Player = get_tree().get_first_node_in_group("player")

signal OnEnemyKilled

func _init(_damage, _speed):
	
	damage = _damage
	speed = _speed


func _ready():
	var thing = player.get_node("Item").get_node_or_null("AdrenalineRush")
	if thing != null:
		adrenaline_rush = true
		connect("OnEnemyKilled", thing.DoJob)
	var ls = player.get_node("Item").get_node_or_null("LeechSpeed")
	if ls != null:
		if ls.active:
			leech_seed = ls.active
func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	travelled_dist += speed * delta
	if travelled_dist > RANGE:
		queue_free()


func _on_ghost_timer_timeout():
	if game_manager.timeSlowFlag:
		var this_ghost = preload("res://Sprite/Ghost.tscn").instantiate()
		get_tree().get_first_node_in_group("GameManager").get_parent().add_child(this_ghost)
		this_ghost.position = position
		this_ghost.texture = sprite.texture
		this_ghost.flip_h = sprite.flip_h
		this_ghost.scale = scale
		this_ghost.rotation = rotation


func _on_area_entered(area):
	if leech_seed:
		area.SetStatusOther("leeched" , 5)
		var ls = player.get_node("Item").get_node_or_null("LeechSpeed")
		if ls != null:
			ls.StartCooldown()
		
