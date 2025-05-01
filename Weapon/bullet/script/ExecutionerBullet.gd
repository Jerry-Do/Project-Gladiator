extends BaseBullet

var c_damage = 10
var c_speed = 1800
var gun : Weapon = null
func _init():
	super._init(c_damage, c_speed)

func _physics_process(delta):
	super._physics_process(delta)
	
func _on_area_entered(area):
	super(area)
	var random = 0
	if player.can_crit:
		random = RandomNumberGenerator.new().randi_range(player.stats.ReturnCritChance(), 200 - player.stats.ReturnCritChance())
	if area.has_method("TakingDamageForOther"):
		damage *= (1 + (player.stats.ReturnDamageMod() / 100.0))
		damage = (damage if random != 100 else damage * (1 + (player.stats.ReturnCritDamage()/100)))
		if area.TakingDamageForOther(damage,  false, faction, random == 100) <= 0 :
			if adrenaline_rush:
				OnEnemyKilled.emit()
			gun.can_use_ability = true
			gun.cooldown_timer.stop()
			get_tree().get_first_node_in_group("GameManager").AdjustFame(1)
	queue_free()
