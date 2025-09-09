extends Area2D
class_name BaseBullet
@onready var game_manager = get_tree().get_first_node_in_group("GameManager")
@onready var sprite = $Bullet
@onready var player : Player = get_tree().get_first_node_in_group("player")
@onready var pa : Item = player.itemNode.get_node_or_null("ProjectileAcceleration")
var weapon_parent : Weapon
var travelled_dist = 0
var damage : int
var speed : int
var crit_chance 
var leech_seed : bool
var adrenaline_rush : bool
const RANGE = 1500
var faction : String
var counter : float = 0
var status_dictionary : Dictionary[String, bool] ={
	"stun" : false,
	"fire" : false,
	"toxin" : false
}

signal OnEnemyKilled

func _init(_damage, _speed):
	damage = _damage
	speed = _speed


func _ready():
	UpgradeBullet()
	weapon_parent = player.currentWeapon
	damage  *= (1 if player.just_dash == false else 2)
	#var ls = player.get_node("Item").get_node_or_null("LeechSpeed")
	var event_manager : EventManager = game_manager.get_node("EventManager")
	connect("OnEnemyKilled", player.get_node("Item").OnEnemyKilled)
	#if ls != null:
		#if ls.active:
			#leech_seed = ls.active
	#if event_manager.event_dict.frenzy_hormone:
		#damage *= 2
		
func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	travelled_dist += speed * delta
	if travelled_dist > RANGE:
		queue_free()
	


func _on_ghost_timer_timeout():
	if game_manager.timeSlowFlag:
		var this_ghost = preload("res://Sprite/Ghost.tscn").instantiate()
		get_tree().get_first_node_in_group("GameManager").get_parent().add_child(this_ghost)
		this_ghost.position = position
		this_ghost.texture = sprite.texture
		this_ghost.flip_h = sprite.flip_h
		this_ghost.scale = scale
		this_ghost.rotation = rotation


func _on_area_entered(area):
	if pa != null:
		damage = clampf(damage + damage * (pa.EffectAmount() * (roundi(travelled_dist) / pa.dmg_per_distant)), damage, damage * 2)
		print("Dmg increased" , damage)
	if area.has_method("DestroyProp"):
		queue_free()
		area.DestroyProp()
	#if leech_seed:
		#area.SetStatusOther("leeched" , 5)
		#var ls = player.get_node("Item").get_node_or_null("LeechSpeed")
		#if ls != null:
			#ls.StartCooldown()
	for i in status_dictionary:
		if area.has_method("SetStatusOther"):
			if status_dictionary[i]:
				area.SetStatusOther(i , 1)

func BulletIden():
	pass

func UpgradeBullet():
	for i in player.itemNode.bullet_upgrades:
		i.UpgradeBullet(self)
	if player.state_machine.current_state.name == "GunslingerSkill" \
	&& player.state_machine.current_state.bullet_upgrade_flag:
		var random_no = RandomNumberGenerator.new().randi_range(0, player.state_machine.current_state.bullet_upgrades.size() - 1)
		player.state_machine.current_state.bullet_upgrades[random_no].UpgradeBullet(self)
	
		
