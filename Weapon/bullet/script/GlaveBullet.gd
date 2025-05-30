extends Area2D
@onready var game_manager = get_tree().get_first_node_in_group("GameManager")
@onready var player = get_tree().get_first_node_in_group("player")
var travelled_dist = 0
var returnFlag : bool 
@export var damage : int
@onready var sprite = $Bullet
var leech_seed
var faction = "tech"
func _ready():
	var ls = player.get_node("Item").get_node_or_null("LeechSpeed")
	if ls != null:
		if ls.active:
			leech_seed = ls.active
	await get_tree().create_timer(1).timeout
	monitoring = true
	
func _physics_process(delta):
	const SPEED = 1000
	var direction = Vector2.RIGHT.rotated(rotation)
	if returnFlag:
		position = position.move_toward(player.position,2 if game_manager.timeSlowFlag else 12)
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
		game_manager.get_parent().add_child(this_ghost)
		this_ghost.position = position
		this_ghost.texture = sprite.texture
		this_ghost.flip_h = sprite.flip_h
		this_ghost.scale = scale
		this_ghost.rotation = sprite.rotation


func _on_area_entered(area):
	var random
	if area.has_method("DestroyProp"):
		queue_free()
		area.DestroyProp()
	if leech_seed:
		area.SetStatusOther("leeched" , 5)
		var ls = player.get_node("Item").get_node_or_null("LeechSpeed")
		if ls != null:
			ls.StartCooldown()
	if player.can_crit:
		random = RandomNumberGenerator.new().randi_range(player.stats.ReturnCritChance(), 200 - player.stats.ReturnCritChance())
	if area.has_method("TakingDamageForOther"):
		damage *= (1 + (player.stats.ReturnDamageMod() / 100.0))
		damage = (damage if random != 100 else damage * (1 + (player.stats.ReturnCritDamage()/100)))
		var amount = area.TakingDamageForOther(damage, false, faction, random == 100)
		if amount != null && amount <= 0 && returnFlag:
			get_tree().get_first_node_in_group("GameManager").AdjustFame(1)
		returnFlag = true
