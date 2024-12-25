extends BaseBullet

var c_damage = 5
var c_speed = 1000
var num_pellet = 10

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
		damage = (damage if random != crit_chance else damage * (1 + (player.stats.ReturnCritDamage()/100)) * (1 + (player.stats.ReturnDamageMod() / 100)))
		var enemy_health = area.TakingDamageForOther(damage, true if area.get_name() == "Back" else false)
		if enemy_health <= 0  && adrenaline_rush:
			OnEnemyKilled.emit()
		if random == crit_chance:
			print("crit")
			var crit_label = preload("res://UI/Critlabel.tscn")
			var new_label = crit_label.instantiate()
			get_node("../../../../../../../Level").add_child(new_label)
			new_label.position = position	
		for n in num_pellet:
			var random_no =  RandomNumberGenerator.new().randi_range(0, num_pellet)
			var pellet = preload("res://Weapon/bullet/ScatterPellet.tscn")
			var new_pellet = pellet.instantiate() 
			new_pellet.position = area.global_position - Vector2(10,10)
			new_pellet.rotation = global_rotation + random_no
			get_parent().call_deferred("add_child",new_pellet)
		queue_free()
	
