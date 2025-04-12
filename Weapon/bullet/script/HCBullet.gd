extends BaseBullet

var c_damage = 8
var c_speed = 30
var current_velocity
var lock_on_target

func _init():
	super._init(c_damage, c_speed)
func _ready():
	current_velocity = speed * Vector2.RIGHT.rotated(rotation)
func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation).normalized()
	if lock_on_target != null:
		direction = global_position.direction_to(lock_on_target.global_position)
	var desired_velocity = direction * speed
	var previous_velocity = current_velocity
	var change = (desired_velocity - current_velocity)
	current_velocity += change
	position += current_velocity * speed * delta
	look_at(global_position + current_velocity)
	travelled_dist += speed * delta
	if travelled_dist > RANGE:
		queue_free()


	



func _on_area_entered(area):
	super(area)
	var random = 0
	var crit_chance = 100 - player.stats.ReturnCritChance()
	if player.can_crit:
		random = RandomNumberGenerator.new().randi_range(1, crit_chance + 1)
	if area.has_method("TakingDamageForOther"):
		damage *= (1 + (player.stats.ReturnDamageMod() / 100))
		damage = (damage if random != crit_chance else damage * (1 + (player.stats.ReturnCritDamage()/100)))
		var amount = area.TakingDamageForOther(damage, true if area.get_name() == "Back" else false, faction,random == crit_chance)
		if amount <= 0:
			get_parent().target_bullet_flag = true
		queue_free()
		


func _on_detection_range_area_entered(area):
	if lock_on_target != null:
		return
	if area.has_method("TakingDamageForOther"):
		if area.get_parent().is_target:
			monitoring = false
			lock_on_target = area


func _on_lock_on_targer_detection_area_entered(area):
	if area == lock_on_target:
		monitoring = true
