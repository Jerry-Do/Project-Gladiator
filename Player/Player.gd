class_name Player
extends CharacterBody2D
@onready var game_manager = get_node("../GameManager")
@onready var weaponNode: Node2D = get_node("Weapon")
@onready var itemNode: Node2D = get_node("Item")
@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@onready var healthBar = get_node("../../UI/Control/Healthbar")
@onready var fuelBar = get_node("../../UI/Control/Fuelbar")
@export var max_speed: int = 1000
var shield : int
var dashTime = 2
var currentWeapon: Node2D
var direction : Vector2
var stats = PlayerStats
var currentItem: Node2D
var invincibleState : bool = false
var recharge_flag : bool = false
@onready 
var state_machine = $StateControl

@onready 
var movement_component = $MovementComponent

	
func _ready():
	self.stats.connect("no_health", queue_free)
	healthBar.init_health(stats.ReturnHealth())
	fuelBar.init_fuel(dashTime)
	state_machine.init(self, movement_component)
	
func _physics_process(delta):
	state_machine.process_physics(delta)
	if currentWeapon:
		currentWeapon.look_at(get_global_mouse_position())
		game_manager.UpdateAmmo(currentWeapon.currentAmmo)

func _process(delta):
	state_machine.process_frame(delta)
	
func _unhandled_input(event):
	state_machine.process_input(event)
	if currentWeapon:
		if event.is_action_pressed("left_click"):			
			currentWeapon.shoot()	
			game_manager.UpdateAmmo(currentWeapon.currentAmmo)
	if currentItem: 
		if event.is_action_pressed("ui_use_relic"):
			currentItem.Use()
			itemNode.remove_child(currentItem)
			currentItem.queue_free()
			currentItem = null
			game_manager.UpdateItemSprite(null)

	
			
func PickUpWeapon(weapon: Node2D):
	weapon.get_parent().call_deferred("remove_child", weapon)
	weaponNode.call_deferred("remove_child", currentWeapon)
	weaponNode.call_deferred("add_child", weapon)
	currentWeapon = weapon

func PickUpItem(item : Node2D):
	item.get_parent().call_deferred("remove_child", item)
	itemNode.call_deferred("remove_child", currentItem)
	itemNode.call_deferred("add_child", item)
	currentItem = item
	game_manager.UpdateItemSprite(currentItem.GetSpritePath())

func MinusHealth(amount : int):
	if !invincibleState:
		stats.SetHealth(amount)
		healthBar._set_health(stats.ReturnHealth())


	
func PickUpBomerang():
	currentWeapon.currentAmmo += 1
	currentWeapon.sprite.set_visible(true)
