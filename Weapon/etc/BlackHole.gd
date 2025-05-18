extends BaseBullet

var c_damage : float = 10
var c_speed : int = 0
var sucked_enemies : Array

func _init():
	super._init(c_damage, c_speed)
	
func _on_area_entered(area):
	if area.has_method("TakingDamageForOther"):
		sucked_enemies.append(area)
		
func _process(delta):
	if sucked_enemies.is_empty() == false:
		for e in sucked_enemies:
			e.get_parent().velocity = Vector2.ZERO
			e.get_parent().velocity = e.get_parent().position.direction_to(global_position) * 300
			e.get_parent().move_and_slide()



func _on_timer_timeout():
	CreateExplosion()

func CreateExplosion():
	$Bullet.hide()
	$CollisionShape2D.disabled = true
	$Explosion.show()
	$Explosion.PlayAnimation()


func _on_explosion_area_entered(area):
	var random : int = 0
	if player.can_crit:
		random = RandomNumberGenerator.new().randi_range(player.stats.ReturnCritChance(), 200 - player.stats.ReturnCritChance())
	if area.has_method("TakingDamageForOther"):
		damage *= (1 + (player.stats.ReturnDamageMod() / 100.0))
		damage = (damage if random != 100 else damage * (1 + (player.stats.ReturnCritDamage()/100)))
		if area.TakingDamageForOther(damage, false, faction, random == 100) <= 0 && adrenaline_rush:
			OnEnemyKilled.emit()


func _on_area_exited(area):
	if area.has_method("TakingDamageForOther"):
		sucked_enemies.remove_at(sucked_enemies.find(area))
