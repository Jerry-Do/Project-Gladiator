extends Enemy


var sHealth:int = 3
var sSpeed: float = 250
var sDamage: float = 5
var sArmor : float = 2
var sFameAmount : float = 1
var wind_up_time : bool =  2
var end_division_flag : bool = false
var sCurrency : int = 1
func _init():
	super._init(sHealth, sSpeed, sDamage, sArmor, sFameAmount, sCurrency)
	

	
func _physics_process(delta):
	super._physics_process(delta)
	

func AttackPlayer():
	playerHitBox.TakingDamageForPlayer(-sDamage, true if playerHitBox.get_name() == "Back" else false, self)
	game_manager.AdjustFame(-(game_manager.currentFame * 0.10))
	%AttackWindup.start(2)

func PlayerLeft():
	inRange = false
	playerHitBox = null

func OnDead():
	super()
	if health <= 0 && end_division_flag == false && evo_flag:
		for i in 2:
			var slime = preload("res://Enemy/Slime.tscn")
			var real = slime.instantiate()
			real.position = global_position
			get_tree().get_first_node_in_group("GameManager").get_parent().add_child(real)
			real.end_division_flag = true
