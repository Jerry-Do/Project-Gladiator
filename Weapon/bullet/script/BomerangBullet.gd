extends Area2D
@onready var game_manager = get_node("../../../../GameManager")
var travelled_dist = 0
var returnFlag : bool 
@export var damage : int
@onready var sprite = $Bullet
func _physics_process(delta):
	const SPEED = 1000
	var direction = Vector2.RIGHT.rotated(rotation)
	if returnFlag:
		position = position.move_toward(get_node("../../../../Player").position,2 if game_manager.timeSlowFlag else 12)
	else:
		position += direction * SPEED * delta
	sprite.rotate(0.25)


func _on_body_entered(body):
	if body.has_method("PickUpBomerang"):
		body.PickUpBomerang()
		queue_free()

func _on_return_timer_timeout():
	returnFlag = true


func _on_ghost_timer_timeout():
	if game_manager.timeSlowFlag:
		var this_ghost = preload("res://Sprite/Ghost.tscn").instantiate()
		get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().add_child(this_ghost)
		this_ghost.position = position
		this_ghost.texture = sprite.texture
		this_ghost.flip_h = sprite.flip_h
		this_ghost.scale = scale
		this_ghost.rotation = sprite.rotation


func _on_area_entered(area):
	if area.has_method("TakingDamage"):
		returnFlag = true
		area.TakingDamage(damage,true if area.get_name() == "Back" else false)
	
