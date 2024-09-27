extends Area2D

var travelled_dist = 0
const SPEED = 35
const RANGE = 1000
@export var damage : int
var crit_chance 
@onready var game_manager = get_node("../../../../../../GameManager")
@onready var sprite = $Bullet
@onready var nav_agent = $NavigationAgent2D
var current_velocity
var lock_on_target
func _ready():
	current_velocity = SPEED * Vector2.RIGHT.rotated(rotation)
func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation).normalized()
	
	if lock_on_target != null:
		direction = global_position.direction_to(lock_on_target.global_position)
	var desired_velocity = direction * SPEED
	var previous_velocity = current_velocity
	var change = (desired_velocity - current_velocity)
	current_velocity += change
	position += current_velocity * SPEED * delta
	look_at(global_position + current_velocity)
	travelled_dist += SPEED * delta
	if travelled_dist > RANGE:
		queue_free()


func _on_body_entered(body):
	var random
	if get_node("../../../../../../Player").can_crit:
		random = RandomNumberGenerator.new().randi_range(1, 5)
		print(random)
	if body.has_method("take_damage"):
		body.take_damage(damage if random != 1 else damage * 2)
		if random == 10:
			print("crit")
			var crit_label = preload("res://UI/Critlabel.tscn")
			var new_label = crit_label.instantiate()
			get_node("../../../../../../../Level").add_child(new_label)
			new_label.position = position	
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


func _on_detection_range_body_entered(body):
	if lock_on_target != null:
		return
	if body.has_method("take_damage"):
		print("lock on")
		if body.is_target:
			lock_on_target = body
