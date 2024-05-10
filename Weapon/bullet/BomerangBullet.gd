extends Area2D

var travelled_dist = 0
var returnFlag : bool 
@export var damage : int
@onready var sprite = $Bullet
func _physics_process(delta):
	const SPEED = 1000
	var direction = Vector2.RIGHT.rotated(rotation)
	if returnFlag:
		position = position.move_toward(get_node("../../../../Player").position,12)
	else:
		position += direction * SPEED * delta
	rotate(0.1)
	sprite.rotate(0.25)


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		returnFlag = true
	if body.has_method("PickUpBomerang"):
		body.PickUpBomerang()
		queue_free()


func _on_return_timer_timeout():
	returnFlag = true
