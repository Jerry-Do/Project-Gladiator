extends Enemy

@onready var aim : Marker2D = $Aim
var sHealth:int = 5
var sSpeed: float = 200
var sDamage: float = 3
var sFameAmount : float = 1
var sArmor : float =  0
var wind_up_time : bool = 1
var sFaction : String = "tech"
var sCurrency : int = 2

func _init():
	super._init(sHealth, sSpeed, sDamage, sArmor,sFameAmount, sCurrency, sFaction, wind_up_time)
	
func _ready():
	super()
	
func _physics_process(delta):
	super._physics_process(delta)
	if player != null:
		aim.set_rotation(get_angle_to(player.position) * scale.y)

func Attack():
	player.target_sprite.show()
	var BULLET = preload("res://Enemy/etc/EnemyBullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = aim.global_position
	new_bullet.global_rotation = aim.global_rotation
	new_bullet.shooter = self
	new_bullet.damage = stats_dic.damage
	player.get_parent().add_child(new_bullet)
	%AttackWindup.start(stats_dic.windup_time)

func PlayerLeft():
	inRange = false
	thingHitBox = null
	if player != null:
		player.target_sprite.hide()
