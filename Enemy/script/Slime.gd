extends Enemy


var sHealth:int = 3
var sSpeed: float = 200
var sDamage: float = 1
var sArmor : float = 2
var sFameAmount : float = 1
var wind_up_time : bool =  2
var end_division_flag : bool = false
var sCurrency : int = 1
var sFaction = "biochemical"
func _init():
	super._init(sHealth, sSpeed, sDamage, sArmor, sFameAmount, sCurrency, sFaction, wind_up_time)
	

	
func _physics_process(delta):
	super._physics_process(delta)
	

func Attack():
	if thingHitBox != null:
		if thingHitBox.has_method("TakingDamageForPlayer"):
			thingHitBox.TakingDamageForPlayer(-stats_dic.damage, true if thingHitBox.get_name() == "Back" else false, self)
			game_manager.AdjustFame(-(game_manager.currentFame * 0.10))
			%AttackWindup.start(stats_dic.windup_time)
		elif thingHitBox.has_method("DestroyProp"):
			thingHitBox.DestroyProp()
			%AttackWindup.start(stats_dic.windup_time)

func PlayerLeft():
	inRange = false
	thingHitBox = null

func OnDead():
	super()
	if stats_dic.health <= 0 && end_division_flag == false && evo_flag:
		for i in 2:
			var slime = preload("res://Enemy/Slime.tscn")
			var real = slime.instantiate()
			real.position = global_position
			get_tree().get_first_node_in_group("GameManager").get_parent().add_child(real)
			real.end_division_flag = true
