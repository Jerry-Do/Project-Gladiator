extends BaseBullet

var c_damage: int  = 5
var c_speed : int = 1000
var num_pellet : int = 10
var extra_damage : int = 2
var fully_charged = false
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
		damage = damage if random != crit_chance else damage * (1 + (player.stats.ReturnCritDamage()/100))
		if fully_charged:
			damage += extra_damage			
		var amount = area.TakingDamageForOther(damage, true if area.get_name() == "Back" else false, faction, random == crit_chance)
		if amount <= 0:
			if adrenaline_rush:
				OnEnemyKilled.emit()
			if fully_charged:
				get_tree().get_first_node_in_group("GameManager").AdjustFame(1)
		queue_free()
