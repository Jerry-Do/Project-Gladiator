extends CharacterBody2D
class_name Player

@onready var game_manager = get_node("../GameManager")
@onready var weaponNode: Node2D = get_node("Weapon")
@onready var itemNode: Node2D = get_node("Item")
@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var healthBar = get_node("../UI/Control/Healthbar")
@onready var fuelBar = get_node("../UI/Control/Fuelbar")
@onready var target_sprite = $Target
@export var max_speed: int = 1000
var can_crit = false
var shield_amount : int
var dashTime = 2
var currentWeapon: Node2D
var direction : Vector2
var stats = PlayerStats
var currentItem: Node2D
var invincibleState : bool = false
var recharge_flag : bool = false
var taking_damage : bool = false
var is_invisible = false
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
		currentWeapon.playerDetector.set_monitoring(false)
		currentWeapon.look_at(get_global_mouse_position())
		game_manager.UpdateAmmo(currentWeapon.currentAmmo)
		
func _process(delta):
	taking_damage = false
	var mouse_pos = get_viewport().get_mouse_position()
	var direction = get_global_mouse_position() - global_position
	
	if direction.sign().x != scale.y:
		set_scale(Vector2(1, scale.y*-1))
		set_rotation_degrees(get_rotation_degrees() + 180 * -1)
		
	state_machine.process_frame(delta)
	
func _unhandled_input(event):
	state_machine.process_input(event)
	if currentWeapon:
		if event.is_action_pressed("left_click"):			
			currentWeapon.shoot()	
			game_manager.UpdateAmmo(currentWeapon.currentAmmo)
		if event.is_action_pressed("right_click") && currentWeapon.has_method("UseGunAbility"):
			currentWeapon.UseGunAbility()
	if currentItem: 
		if event.is_action_pressed("ui_use_relic"):
			currentItem.Use()
			itemNode.remove_child(currentItem)
			currentItem.queue_free()
			currentItem = null
			game_manager.UpdateItemSprite(null)

	
			
func PickUpWeapon(weapon: Node2D):
	if weapon != null:
		get_parent().call_deferred("remove_child", weapon)
	if currentWeapon != null:	
		weaponNode.call_deferred("remove_child", currentWeapon)
	weaponNode.call_deferred("add_child", weapon)
	currentWeapon = weapon
	game_manager.pick_up_weapon = true


func MinusHealth(amount : int, is_backshot = false):
	if !invincibleState:
		if shield_amount > 0:	
			get_node("Item/Shield").TakingDamage()
			shield_amount += amount * 2 if is_backshot else amount * 1
			healthBar._set_shield(shield_amount)
			print(stats.ReturnHealth())
		else:
			
			stats.SetHealth(amount * 2 if is_backshot else  amount * 1)
			healthBar._set_health(stats.ReturnHealth())
			print(stats.ReturnHealth())
	

	
func PickUpBomerang():
	currentWeapon.currentAmmo += 1
	currentWeapon.sprite.set_visible(true)
