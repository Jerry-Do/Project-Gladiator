extends CharacterBody2D
class_name Enemy
@onready 
var player : Player = get_tree().get_first_node_in_group("player")

@onready 
var game_manager : GameManager = get_tree().get_first_node_in_group("GameManager")

@onready 
var event_manager : EventManager = get_tree().get_first_node_in_group("GameManager").get_node("EventManager")

@onready
var softCollision = $SoftCollision

@onready 
var spawner = get_tree().get_first_node_in_group("GameManager").get_node("Spawner")

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
var stats_dic = {
	"health" : 0,
	"speed" : 0,
	"damage" : 0,
	"armor" : 0,
	"windup_time" : 0
}
var faction : String = ""
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
func _init(health: int, speed: float, damage: float, armor : float ,fame : int, currency : int, faction : String, windup_time : float):
	self.stats_dic.health = health
	self.stats_dic.speed = speed * (1.5 if GameManager.instance.event_manager.event_dict.frenzy_hormone else 1)
	self.stats_dic.damage = damage
	self.fameAmount = 1 * (2 if GameManager.instance.event_manager.event_dict.frenzy_hormone else 1)
	self.stats_dic.armor = armor
	self.stats_dic.windup_time = windup_time / (2 if GameManager.instance.event_manager.event_dict.frenzy_hormone else 1)
	self.currency_amount = currency
	self.faction = faction
	
func _ready() -> void:
	health_bar = $Healthbar
	LevelUp()
	state_manager.init(self, movement_controller)	
	health_bar.init_health(self.stats_dic.health)
	if player.get_node("Item").get_node_or_null("BrainChip") != null:
		health_bar.show()

	
func _physics_process(delta: float):
	state_manager.process_physics(delta)
	if status_dictionary.leeched:
		delta_count += delta
		if delta_count >= leech_dmg_timer:
			var dmg = 0.5 * (2  if player.get_node("Item").item_critable else 1)
			stats_dic.health -= dmg
			CreateDamageLabel(dmg, false)
			delta_count = 0
			player.stats.SetHealth(dmg)
			
func MinusHealth(amount : float, is_backshot: bool, faction: String, crit : bool):
	amount *= (1.2 if is_backshot else 1.0  )
	amount *= (1.1 if self.faction != faction else 1.0)
	amount /= ( 1 + (stats_dic.armor/2.0)/ 100.0)
	CreateDamageLabel(amount, crit)
	stats_dic.health -= amount
	health_bar._set_health(stats_dic.health)
	return stats_dic.health

func CreateDamageLabel(amount : float, crit : bool):
	var dmg_label = preload("res://UI/DamageLabel.tscn")
	var real =  dmg_label.instantiate()
	real.position = position
	real.get_child(0).text = ("Critical: " if crit else "") + ("%.2f" % -amount)
	get_tree().get_first_node_in_group("GameManager").get_parent().add_child(real)
	
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
	stats_dic.health += level
	stats_dic.damage += level * (2 if event_manager.event_dict.frenzy_hormone else 1)
	fameAmount += level
	stats_dic.armor += level * 0.25
	if level == 7:	
		evo_flag = true

func OnDead():
	var extra_material_amount = 0
	if player.get_node("Item").get_node_or_null("GamblerDice") != null:
		extra_material_amount = randi_range(0, player.get_node("Item").get_node_or_null("GamblerDice").amount)
	game_manager.AdjustCurrency(currency_amount + extra_material_amount)	
	OnDeath.emit(self)


	
