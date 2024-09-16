extends CharacterBody2D
class_name Enemy
var health: int
var speed: float
var damage: float
var fameAmount : int
var chase: bool
@onready 
var player = get_node("../Player")

@onready
var navAgent = $NavigationAgent2D 

@onready
var softCollision = $SoftCollision

@onready var spawner = get_node("../Spawner")

@onready 
var sprite = $AnimatedSprite2D

@onready 
var state_manager = $StateControl

@onready 
var movement_controller = $MovementController

func _init(health: int, speed: float, damage: float, fame : int):
	self.health = health
	self.speed = speed
	self.damage = damage
	self.fameAmount = fame
	
func _ready() -> void:
	state_manager.init(self, movement_controller)	



	
func _physics_process(delta: float):
	state_manager.process_physics(delta)
	



	
func take_damage(amount : int):
	health -= amount
	


func ReturnFame():
	return fameAmount
