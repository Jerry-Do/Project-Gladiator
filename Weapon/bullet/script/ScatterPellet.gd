extends BaseBullet

var c_damage = 0 
var c_speed = 1000

func _init():
	super._init(c_damage, c_speed)

func _physics_process(delta):
	super._physics_process(delta)


func _on_area_entered(area):
	var random = 0
	var crit_chance = 100 - player.stats.ReturnCritChance()
	if player.can_crit:
		random = RandomNumberGenerator.new().randi_range(1, crit_chance)
	if area.has_method("TakingDamageForOther"):
		var amount = area.TakingDamageForOther(damage if random != crit_chance else damage * (1 + (player.stats.ReturnCritChance()/100)), true if area.get_name() == "Back" else false)
		if amount <= 0:
			get_tree().get_first_node_in_group("GameManager").AdjustFame(1)
		if random == crit_chance:
			print("crit")
			var crit_label = preload("res://UI/Critlabel.tscn")
			var new_label = crit_label.instantiate()
			get_node("../../../../../../../Level").add_child(new_label)
			new_label.position = position	
		queue_free()
