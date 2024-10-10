extends CharacterBody2D
class_name Enemy
var health: int
var speed: float
var damage: float
var fameAmount : int
var chase: bool
var inRange: bool = false
var playerHitBox : Node2D
@onready 
var player : Player = get_node("../Player")

@onready 
var game_manager = get_node("../GameManager")


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

var is_target = false
var curse_timer
var status_dictionary = {
	"Stun" : false
}


func _init(health: int, speed: float, damage: float, fame : int):
	curse_timer = Timer.new()
	add_child(curse_timer)
	curse_timer.wait_time = 99
	curse_timer.one_shot = true
	curse_timer.connect("timeout", _on_curse_timer_timeout)
	self.health = health
	self.speed = speed
	self.damage = damage
	self.fameAmount = fame
	
	
func _ready() -> void:
	self.health += game_manager.currentWave
	state_manager.init(self, movement_controller)	



	
func _physics_process(delta: float):
	state_manager.process_physics(delta)
	

func MinusHealth(amount : int, is_backshot: bool):
	print(amount)
	health -= amount * (1.2 if is_backshot else 1)
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
	curse_timer.start()
	

func _on_curse_timer_timeout():
	is_target = false
	target_sprite.hide()
	

	
