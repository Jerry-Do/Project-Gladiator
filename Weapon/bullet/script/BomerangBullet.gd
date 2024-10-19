extends Area2D
@onready var game_manager = get_node("../../../../GameManager")
@onready var player = get_node("../../../../../../Player")
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
	var random
	var crit_chance = 100 - player.stats.ReturnCritChance()
	if get_node("../../../../../../Player").can_crit:
		random = RandomNumberGenerator.new().randi_range(1, 100 - (player.stats.ReturnCritChance()))
	if area.has_method("TakingDamageForOther"):
		damage = (damage if random != crit_chance else damage * (1 + (player.stats.ReturnCritDamage()/100)) * (1 + (player.stats.ReturnDamageMod() / 100)))
		area.TakingDamageForOther(damage, true if area.get_name() == "Back" else false)
		if random == (100 - (get_node("../../../../../../Player").stats.ReturnCritChance())):
			print("crit")
			var crit_label = preload("res://UI/Critlabel.tscn")
			var new_label = crit_label.instantiate()
			get_node("../../../../../../../Level").add_child(new_label)
			new_label.position = position	
