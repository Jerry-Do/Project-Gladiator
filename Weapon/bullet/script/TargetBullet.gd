extends Area2D

var travelled_dist = 0
@export var damage : int
var crit_chance 
@onready var game_manager = get_node("../../../../../../GameManager")
@onready var sprite = $Bullet
func _physics_process(delta):
	const SPEED = 1000
	const RANGE = 800
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travelled_dist += SPEED * delta
	if travelled_dist > RANGE:
		queue_free()


func _on_body_entered(body):
	if body.has_method("SetTarget"):
		body.SetTarget()
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
