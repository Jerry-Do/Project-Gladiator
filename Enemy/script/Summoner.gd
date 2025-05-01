extends Enemy

@export var enemies : Array
var sHealth:int = 3
var sSpeed: float = 250
var sDamage: float = 1
var sArmor : float = 2
var sFameAmount : float = 1
var wind_up_time : bool =  2
var end_division_flag : bool = false
var sCurrency : int = 1
var sFaction = "R.I.S.K"

func _init():
	super._init(sHealth, sSpeed, sDamage, sArmor, sFameAmount, sCurrency, sFaction, wind_up_time)
	

	
func _physics_process(delta):
	super._physics_process(delta)
	

func Attack():
	var randomNo = randi_range(0,enemies.size() - (1 if evo_flag else 2)) 
	var enemy = load(enemies[randomNo])
	var real = enemy.instantiate()
	real.position = position
	get_parent().add_child(real)
	

func PlayerLeft():
	inRange = false
	

func OnDead():
	super()
	if stats_dic.health <= 0 && end_division_flag == false && evo_flag:
		for i in 2:
			var slime = preload("res://Enemy/Slime.tscn")
			var real = slime.instantiate()
			real.position = global_position
			get_tree().get_first_node_in_group("GameManager").get_parent().add_child(real)
			real.end_division_flag = true
