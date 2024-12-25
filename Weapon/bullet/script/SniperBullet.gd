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
	var crit_chance = 100 - player.stats.ReturnCritChance()
	if player.can_crit:
		random = RandomNumberGenerator.new().randi_range(1, crit_chance)
	if area.has_method("TakingDamageForOther"):
		damage = (damage if random != crit_chance else damage * (1 + (player.stats.ReturnCritDamage()/100)) * (1 + (player.stats.ReturnDamageMod() / 100)))
		var amount = area.TakingDamageForOther(damage, true if area.get_name() == "Back" else false)
		if amount <= 0  && adrenaline_rush:
			OnEnemyKilled.emit()
			get_tree().get_first_node_in_group("GameManager").AdjustFame(1)
		if random == crit_chance:
			print("crit")
			var crit_label = preload("res://UI/Critlabel.tscn")
			var new_label = crit_label.instantiate()
			get_node("../../../../../../../Level").add_child(new_label)
			new_label.position = position	
	if health <= 0:
		queue_free()
