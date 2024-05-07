extends Area2D


var travelled_dist = 0
@export var health : int
@export var damage : int
func _physics_process(delta):
	const SPEED = 2500
	const RANGE = 800
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_dist += SPEED * delta
	if travelled_dist > RANGE || health <= 0:
		queue_free()


func _on_body_entered(body):
	health -= 1
	damage -= 1
	if body.has_method("take_damage"):
		body.take_damage(damage)

