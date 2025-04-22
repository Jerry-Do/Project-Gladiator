extends BaseBullet
var c_damage = 1
var c_speed = 1000

func _init():
	super._init(c_damage, c_speed)

func _physics_process(delta):
	super._physics_process(delta)
	
func _on_area_entered(area):
	super(area)
	var random = 0
	var crit_chance = 100 - player.stats.ReturnCritChance()
	if player.can_crit:
		random = RandomNumberGenerator.new().randi_range(1, crit_chance)
	if area.has_method("TakingDamageForOther"):
		damage *= (1 + (player.stats.ReturnDamageMod() / 100))
		damage = (damage if random != crit_chance else damage * (1 + (player.stats.ReturnCritDamage()/100)))
		if area.TakingDamageForOther(damage, true if area.get_name() == "Back" else false, faction, random == crit_chance) <= 0 && adrenaline_rush:
			OnEnemyKilled.emit()
		queue_free()
