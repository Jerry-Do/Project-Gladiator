extends Area2D

@export var num_pellet = 10
var travelled_dist = 0
@export var damage : int
var crit_chance 
@onready var game_manager = get_tree().get_first_node_in_group("GameManager")
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
	var random
	if get_tree().get_first_node_in_group("player").can_crit:
		random = RandomNumberGenerator.new().randi_range(1, 5)
	if body.has_method("take_damage"):
		body.take_damage(damage if random != 1 else damage * 2)
		if random == 10:
			print("crit")
			var crit_label = preload("res://UI/Critlabel.tscn")
			var new_label = crit_label.instantiate()
			get_node("../../../../../../../Level").add_child(new_label)
			new_label.position = position
		for n in num_pellet:
			var random_no =  RandomNumberGenerator.new().randi_range(0, num_pellet)
			var pellet = preload("res://Weapon/bullet/ScatterPellet.tscn")
			var new_pellet = pellet.instantiate()
			new_pellet.position = body.global_position+body.hitbox.shape.get_rect().size
			new_pellet.rotation = global_rotation + random_no
			get_parent().call_deferred("add_child", new_pellet)
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
