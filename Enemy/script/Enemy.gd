extends CharacterBody2D
class_name Enemy
@onready 
var player : Player = get_tree().get_first_node_in_group("player")

@onready 
var game_manager : GameManager = get_tree().get_first_node_in_group("GameManager")


@onready
var softCollision = $SoftCollision

@onready 
var spawner = get_node("../Spawner")

@onready 
var sprite = $Sprite2D

@onready 
var state_manager = $StateControl

@onready 
var movement_controller = $MovementController

@onready
var target_sprite = $Target

@onready
var animation_player : AnimationPlayer = $AnimationPlayer

signal OnDeath(enemy)

var health_bar : HealthBar
var flipped : bool = false
var health: float
var speed: float
var damage: float
var armor : float 
var fameAmount : int
var chase: bool
var inRange: bool = false
var playerHitBox : Node2D
var level : int
var evo_flag : bool = false
var is_target = false
var curse_timer
var currency_amount : int
var delta_count : float = 0
var leech_dmg_timer : float = 1
var status_dictionary = {
	"stun" : false,
	"slow" : false,
	"vulnerable" : false,
	"leeched" : false
}
var status_timers : Array
var timer_counters = 0
func _init(health: int, speed: float, damage: float, armor : float ,fame : int, currency : int):
	self.health = health
	self.speed = speed
	self.damage = damage
	self.fameAmount = 1
	self.armor = armor
	self.currency_amount = currency
	
func _ready() -> void:
	health_bar = $Healthbar
	LevelUp()
	state_manager.init(self, movement_controller)	
	health_bar.init_health(self.health)
	if player.get_node("Item").get_node_or_null("BrainChip") != null:
		health_bar.show()

	
func _physics_process(delta: float):
	state_manager.process_physics(delta)
	if status_dictionary.leeched:
		delta_count += delta
		if delta_count >= leech_dmg_timer:
			health -= 0.5
			player.stats.SetHealth(0.5)
			
func MinusHealth(amount : float, is_backshot: bool):
	amount *= (1.2 if is_backshot else 1)
	amount /= ( 1 + (armor/2.0)/ 100.0)
	health -= amount
	health_bar._set_health(health)
	return health

	
func ReturnFame():
	return fameAmount

func _on_ghost_timer_timeout():
	if game_manager.timeSlowFlag:
		var this_ghost = preload("res://Sprite/Ghost.tscn").instantiate()
		get_parent().add_child(this_ghost)
		this_ghost.visible = sprite.visible
		this_ghost.position = position
		this_ghost.texture = sprite.texture
		this_ghost.flip_h =  sprite.flip_h
		this_ghost.scale = sprite.scale * scale
		this_ghost.rotation = rotation


func SetTarget():
	is_target = true
	target_sprite.show()
	$CurseTimer.start()
	

func _on_curse_timer_timeout():
	is_target = false
	target_sprite.hide()
	
func SelfDestruct():
	queue_free()


func SetStatusTrue(name_s: String, duration: float):
	if status_dictionary[name_s] == false:
		status_dictionary[name_s] = true
		await get_tree().create_timer(duration).timeout
		status_dictionary[name_s] = false

func LevelUp():
	level = game_manager.currentWave
	health += level
	damage += level
	fameAmount += level
	armor += level * 0.25
	if level == 7:	
		evo_flag = true

func OnDead():
	game_manager.AdjustCurrency(currency_amount)	
	OnDeath.emit(self)

	
