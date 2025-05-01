extends BaseBullet
@export var health : int
var c_damage = 12
var c_speed = 1500


func _init():
	super._init(c_damage, c_speed)

func _physics_process(delta):
	super._physics_process(delta)

func _on_area_entered(area):
	super(area)
	health -= 1
	damage -= 1
	var random = 0
	if player.can_crit:
		random = RandomNumberGenerator.new().randi_range(player.stats.ReturnCritChance(), 200 - player.stats.ReturnCritChance())
	if area.has_method("TakingDamageForOther"):
		damage *= (1 + (player.stats.ReturnDamageMod() / 100.0))
		damage = (damage if random != 100 else damage * (1 + (player.stats.ReturnCritDamage()/100)))
		var amount = area.TakingDamageForOther(damage, false, faction, random == crit_chance)
		if amount <= 0 :
			if adrenaline_rush:
				OnEnemyKilled.emit()
			get_tree().get_first_node_in_group("GameManager").AdjustFame(1)
	if health <= 0:
		queue_free()
