extends BaseBullet
var c_damage = 5
var c_speed = 1000

func _init():
	super._init(c_damage, c_speed)

func _physics_process(delta):
	super._physics_process(delta)
	
func _on_area_entered(area):
	super(area)
	var random = 0
	var enemy_id = area.get_instance_id()
	if player.can_crit:
		random = RandomNumberGenerator.new().randi_range(player.stats.ReturnCritChance(), 200 - player.stats.ReturnCritChance())
	if area.has_method("TakingDamageForOther"):
		
		#TODO: Add push back when enemy hit
		PushEnemyBack(area )
		damage *= (1 + (player.stats.ReturnDamageMod() / 100.0))
		damage = (damage if random != 100 else damage * (1 + (player.stats.ReturnCritDamage()/100)))
		if area.TakingDamageForOther(0, false, faction, random == 100) <= 0:
			weapon_parent.CheckIfTrackingEnemyKilled(enemy_id)
			PushEnemyBack(area)
			OnEnemyKilled.emit()
		queue_free()

func PushEnemyBack(area ):
	if area.get_parent().velocity == Vector2.ZERO:
		var velocity : Vector2 = Vector2.ZERO
		if area.get_parent().position.x < 0:
			velocity.x = -area.get_parent().to_local(self.global_position).x
		else:
			velocity.x = area.get_parent().to_local(self.global_position).x
		if area.get_parent().position.y < 0:
			velocity.y = -area.get_parent().to_local(self.global_position).y
		else:
			velocity.y = area.get_parent().to_local(self.global_position).y
		area.get_parent().velocity = velocity * 750
	else:
		area.get_parent().velocity = -area.get_parent().to_local(self.global_position) * 30
		area.SetStatusOther("stun",0.15)
	area.get_parent().move_and_slide()
