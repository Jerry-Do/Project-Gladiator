extends BaseBullet
@export var health : int
var c_damage = 12
var c_speed = 1500


func _init():
	super._init(c_damage, c_speed)

func _physics_process(delta):
	super._physics_process(delta)





func _on_area_entered(area):
	health -= 1
	damage -= 1
	var random
	if get_node("../../../../../../Player").can_crit:
		random = RandomNumberGenerator.new().randi_range(1, 5)
	if area.has_method("TakingDamageForOther"):
		area.TakingDamageForOther(damage if random != 1 else damage * 2, true if area.get_name() == "Back" else false)
		if random == 1:
			print("crit")
			var crit_label = preload("res://UI/Critlabel.tscn")
			var new_label = crit_label.instantiate()
			get_node("../../../../../../../Level").add_child(new_label)
			new_label.position = position	
	if health <= 0:
		queue_free()
