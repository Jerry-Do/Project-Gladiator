extends CharacterBody2D
class_name Player

@onready var game_manager = get_node("../GameManager")
@onready var weaponNode: Node2D = get_node("Weapon")
@onready var itemNode: Node2D = get_node("Item")
@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var healthBar = get_node("../UI/Control/Healthbar")
@onready var fuelBar = get_node("../UI/Control/Fuelbar")
@onready var back_hitbox : Area2D = $Back
@onready var front_hitbox : Area2D = $Front
@onready var target_sprite = $Target
@onready var state_machine = $StateControl
@onready var movement_component = $MovementComponent
@export var max_speed: int = 100

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
var status_dictionary = {
	"Stun" : false,
	"TimeStopDisable" : false
}

var interactable = null
signal CreateDescription(weapon : Weapon)
	
func _ready():
	self.stats.connect("no_health", game_manager.GameOver)
	connect("CreateDescription", game_manager.CreateWeaponDescription)
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
	#taking_damage = false
	if movement_component.get_movement_direction().sign().x != scale.y && movement_component.get_movement_direction().x != 0:
		set_scale(Vector2(1, scale.y*-1))
		set_rotation_degrees(get_rotation_degrees() + 180 * -1)
	state_machine.process_frame(delta)
	
func _unhandled_input(event):
	state_machine.process_input(event)
	if currentWeapon:
		if event.is_action_pressed("left_click") && status_dictionary.Stun == false:			
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
	if interactable:
		if event.is_action_pressed("interact"):
			interactable.Interaction()
	
			
func PickUpWeapon(weapon: Weapon):
	if weapon != null:
		get_parent().call_deferred("remove_child", weapon)
	if currentWeapon != null:	
		currentWeapon.Queue_Free()
		weaponNode.call_deferred("remove_child", currentWeapon)
	weaponNode.call_deferred("add_child", weapon)
	currentWeapon = weapon
	game_manager.pick_up_weapon = true
	CreateDescription.emit(currentWeapon)


func MinusHealth(amount : int, is_backshot = false):
	if !invincibleState:
		if shield_amount > 0:	
			get_node("Item/EnergyShield").TakingDamage()
			shield_amount += amount * 2 if is_backshot else amount * 1
			healthBar._set_shield(shield_amount)
		else:
			stats.SetHealth(amount * 2 if is_backshot else  amount * 1)
			healthBar._set_health(stats.ReturnHealth())
	

	
func PickUpBomerang():
	currentWeapon.currentAmmo += 1
	currentWeapon.sprite.set_visible(true)

func SetStatusTrue(name: String, duration: float):
	status_dictionary[name] = true
	await get_tree().create_timer(duration).timeout
	status_dictionary[name] = false


func _on_interaction_range_area_entered(area):
	if area.has_method("Interaction"):
		area.get_parent().label.show()
		interactable = area


func _on_interaction_range_area_exited(area):
	if area.has_method("Interaction"):
		area.get_parent().label.hide()
		interactable = null
