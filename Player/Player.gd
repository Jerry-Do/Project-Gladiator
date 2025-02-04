extends CharacterBody2D
class_name Player

@onready var game_manager : GameManager = get_tree().get_first_node_in_group("GameManager")
@onready var weaponNode: Node2D = get_node("Weapon")
@onready var itemNode: Node2D = get_node("Item")
@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var healthBar = get_node("../UI/Control/Healthbar")
@onready var fuelBar = get_node("../UI/Control/Fuelbar")
@onready var item_inventory = $Item
@onready var target_sprite = $Target
@onready var state_machine = $StateControl
@onready var movement_component = $MovementComponent
@onready var stats : Stats = $Stats
@onready var perfect_dodge_timer = %PerfectTimeSlowTimer
@export var max_speed: int = 100

var perfect_dogde_collided : bool = false
var perfect_time_stop_state = false
var shield_amount : int
var currentWeapon: Weapon
var direction : Vector2
var currentItem: Node2D
var invincibleState : bool = false
var recharge_flag : bool = false
var taking_damage : bool = false
var is_invisible = false
var damage_amount = 0
var can_crit = false
var left_click_pressed : bool = false
var status_dictionary = {
	"stun" : false,
	"timeStopDisable" : false,
	"slow" : false
}
var buff_dictionary = {
	"endurance" : false
}
var interactable = null
var can_time_stop : bool = true
signal CreateDescription(weapon : Weapon)
	
func _ready():
	self.stats.connect("no_health", game_manager.GameOver)
	connect("CreateDescription", game_manager.CreateWeaponDescription)
	healthBar.init_health(stats.ReturnHealth())
	fuelBar.init_fuel(stats.maxFuel)
	var skill = load("res://skills/" + SkillPicker.chosen_skill +".tscn")
	var real = skill.instantiate()
	state_machine.add_child(real)
	state_machine.init(self, movement_component)
	game_manager.player = self
	
func _physics_process(delta):
	state_machine.process_physics(delta)
	
	if currentWeapon:
		currentWeapon.playerDetector.set_monitoring(false)
		currentWeapon.look_at(get_global_mouse_position())
		game_manager.UpdateAmmo(currentWeapon.currentAmmo)
		
func _process(delta):
	
	if Input.is_action_pressed("left_click") :
		if currentWeapon && status_dictionary.stun == false && currentWeapon.reloadFlag == false:
			currentWeapon.shoot()	
			game_manager.UpdateAmmo(currentWeapon.currentAmmo)
	state_machine.process_frame(delta)
	
func _input(event):
	state_machine.process_input(event)
	if currentWeapon:
		if event.is_action_pressed("right_click") && currentWeapon.has_method("UseGunAbility"):
			currentWeapon.UseGunAbility()
		if event.is_action_pressed("reload"):
			currentWeapon.StartReloadTimer()
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
	if event.is_action_pressed("move_left"):
		animated_sprite.flip_h = true
	elif event.is_action_pressed("move_right"):
		animated_sprite.flip_h = false
			
func PickUpWeapon(weapon: Weapon):
	if weapon != null:
		get_parent().call_deferred("remove_child", weapon)
	if currentWeapon != null:	
		currentWeapon.queue_free()
		weaponNode.call_deferred("remove_child", currentWeapon)
	weaponNode.call_deferred("add_child", weapon)
	currentWeapon = weapon
	game_manager.pick_up_weapon = true
	CreateDescription.emit(currentWeapon)


func MinusHealth(amount : int,  crit : bool = false, is_backshot = false):
	if !invincibleState:
		damage_amount = amount * 2 if is_backshot else amount * 1	
		damage_amount -= damage_amount * ( 1 + (stats.ReturnArmor()/2.0)) / 100.0
		damage_amount -= (5 if item_inventory.item_sets["bioenhancement"] else 0)
		var dmg_label = preload("res://UI/DamageLabel.tscn")
		var real =  dmg_label.instantiate()
		real.position = position	
		real.get_child(0).text = ("Critical: " if crit else "") + str(-damage_amount)
		get_tree().get_first_node_in_group("GameManager").get_parent().add_child(real)
		if shield_amount > 0:	
			shield_amount += damage_amount
			get_node("Item/EnergyShield").TakingDamage(damage_amount)
			healthBar._set_shield(damage_amount)
			game_manager.AdjustFame(-1)
		else:
			stats.SetHealth(damage_amount)
	

	
func PickUpBomerang():
	currentWeapon.currentAmmo += 1
	currentWeapon.sprite.set_visible(true)

func SetStatusTrue(name_s: String, duration: float):
	if status_dictionary[name_s] == false:
		status_dictionary[name_s] = true
		await get_tree().create_timer(((duration / 2) if item_inventory.item_sets["bioenhancement"] else duration)).timeout
		status_dictionary[name_s] = false


func _on_interaction_range_area_entered(area):
	if area.has_method("Interaction"):
		area.get_parent().label.show()
		interactable = area


func _on_interaction_range_area_exited(area):
	if area.has_method("Interaction"):
		area.get_parent().label.hide()
		interactable = null

	

func Cleanse():
	for key in status_dictionary:
		status_dictionary[key] = false

func _on_perfect_dodge_zone_area_entered(area):
	if area.name == "Attack":
		perfect_dogde_collided = true
		perfect_dodge_timer.start()


func _on_perfect_dodge_timer_timeout():
	perfect_dogde_collided = false

func LevelUp():
	stats.LevelUp()
