extends CharacterBody2D
@onready var level = get_node("/root/Game/Level")
@onready var weaponNode: Node2D = get_node("Weapon")
@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
@export var max_speed: int = 1000
var currentWeapon: Node2D
var direction : Vector2
var canDash = true
var dashing = false

enum{
	IDLE,
	MOVE,
	ROLL,
	ATTACK
}
var stats = PlayerStats
func _ready():
	self.stats.connect("no_health", queue_free)
func _physics_process(delta):
	
	level.UpdateHealth(stats.ReturnHealth())
	var mouseDirection: Vector2 = (get_global_mouse_position() - global_position).normalized()
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction * stats.ReturnSpeed()
	Dash()
	
	move_and_slide()
	if direction.length() != 0:
		animation_player.play("run")
	elif direction.length() == 0:
		animation_player.play("idle")
	if mouseDirection.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouseDirection.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
	if currentWeapon:
		currentWeapon.look_at(get_global_mouse_position())
		level.UpdateAmmo(currentWeapon.currentAmmo)
	
func _input(event):
	
	if currentWeapon:
		if event.is_action_pressed("left_click"):			
			currentWeapon.shoot()	
			level.UpdateAmmo(currentWeapon.currentAmmo)
		

func PickUpWeapon(weapon: Node2D):
	var temp = weapon
	weapon.get_parent().call_deferred("remove_child", weapon)
	weaponNode.call_deferred("remove_child", currentWeapon)
	weaponNode.call_deferred("add_child", weapon)
	currentWeapon = weapon


func MinusHealth(amount : int):
	stats.SetHealth(amount)


func _on_hitbox_area_entered(area):
	pass # Replace with function body.

func Dash():
	if Input.is_action_just_pressed("dash") && canDash:
		velocity *= 50
		canDash = false
		await get_tree().create_timer(3.0).timeout
		canDash = true
	
