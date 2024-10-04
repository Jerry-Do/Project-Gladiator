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
	var random
	if get_node("../../../../../../Player").can_crit:
		random = RandomNumberGenerator.new().randi_range(1, 4)
		print(random)
	if area.has_method("TakingDamageForEnemy"):	
		damage = damage if random != 1 else damage * 2
		if fully_charged:
			damage += extra_damage
		area.TakingDamageForEnemy(damage if random != 1 else damage * 2, true if area.get_name() == "Back" else false)
		if random == 1:
			print("crit")
			var crit_label = preload("res://UI/Critlabel.tscn")
			var new_label = crit_label.instantiate()
			get_node("../../../../../../../Level").add_child(new_label)
			new_label.position = position	
	queue_free()
