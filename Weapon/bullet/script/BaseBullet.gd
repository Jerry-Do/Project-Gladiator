extends Area2D
class_name BaseBullet
var travelled_dist = 0
var damage : int
var speed : int
var crit_chance 
const RANGE = 1500
@onready var game_manager = get_tree().get_first_node_in_group("GameManager")
@onready var sprite = $Bullet
@onready var player : Player = get_node("../../../../../../Player")

func _init(_damage, _speed):
	damage = _damage
	speed = _speed


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	travelled_dist += speed * delta
	if travelled_dist > RANGE:
		queue_free()


func _on_ghost_timer_timeout():
	if game_manager.timeSlowFlag:
		var this_ghost = preload("res://Sprite/Ghost.tscn").instantiate()
		get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().add_child(this_ghost)
		this_ghost.position = position
		this_ghost.texture = sprite.texture
		this_ghost.flip_h = sprite.flip_h
		this_ghost.scale = scale
		this_ghost.rotation = rotation
