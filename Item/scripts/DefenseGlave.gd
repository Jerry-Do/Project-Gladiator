extends Tech

@export var d = 0
@export var radius = 100
@export var speed = 2.0
@export var damage = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	duplicate_flag = false
	price = 80
	item_name = "DefenseGlave"
	display_name = "Defense Glave"
	name = item_name
	item_description = "Create a glave that rotates around the player. Damages anything it touches"
	return null

func _physics_process(delta):
	if get_parent() == player.get_node("Item"):
		d += delta
		%Glave.rotate(0.25)
		%Glave.position = Vector2(sin(d * speed) * radius, cos(d * speed) * radius) + player.get_node("Item").position
		%Glave2.rotate(0.25)
		%Glave2.position = Vector2(sin(d * speed + 400) * radius, cos(d * speed + 400) * radius) + player.get_node("Item").position
		%Glave3.rotate(0.25)
		%Glave3.position = Vector2(sin(d * speed + 800) * radius, cos(d * speed + 800) * radius) + player.get_node("Item").position


func _on_glave_area_entered(area):
	var random = 0
	var crit_chance = 100 - player.stats.ReturnCritChance()
	if player.get_node("Item").item_critable:
		random = RandomNumberGenerator.new().randi_range(1, crit_chance)
	if area.has_method("TakingDamageForOther"):
		area.TakingDamageForOther(damage, false, faction, random == crit_chance)


func _on_timer_timeout():
	for i in get_node("Node").get_children():
		i.monitoring = false
		i.hide()
	$CooldownTimer.start()

func _on_cooldown_timer_timeout():
	for i in get_node("Node").get_children():
		i.monitoring = true
		i.show()
	$UpTimer.start()
