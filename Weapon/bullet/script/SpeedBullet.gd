extends BaseBullet

var c_damage: int  = 5
var c_speed : int = 1000
var extra_damage : int = 2
var fully_charged = false
var lightning_targets : Array
func _init():
	super._init(c_damage, c_speed)

func _physics_process(delta):
	super._physics_process(delta)


func _on_area_entered(area):
	super(area)
	var random = 0
	if player.can_crit:
		random = RandomNumberGenerator.new().randi_range(player.stats.ReturnCritChance(), 200 - player.stats.ReturnCritChance())
	if area.has_method("TakingDamageForOther"):
		damage *= (1 + (player.stats.ReturnDamageMod() / 100.0))
		damage = (damage if random != 100 else damage * (1 + (player.stats.ReturnCritDamage()/100)))
		if fully_charged:
			damage += extra_damage
			position = position
			speed = 0
			if lightning_targets.find(null,0) == -1:
				CreateLightning(area.get_instance_id(),  random == 100)
			$Bullet.hide()
		var amount = area.TakingDamageForOther(damage, false, faction, random == 100)
		if amount <= 0:
			OnEnemyKilled.emit()
			if fully_charged:
				get_tree().get_first_node_in_group("GameManager").AdjustFame(1)
		queue_free()
		


func _on_explosion_area_entered(area):
	if area.has_method("TakingDamageForOther"):
		area.TakingDamageForOther(3,false,faction,false)
		area.SetStatus("stun",1)

func CreateLightning(id : int, crit: bool):
	var lightning = preload("res://Weapon/etc/Lightning.tscn")
	var real = lightning.instantiate()
	get_tree().get_first_node_in_group("GameManager").get_parent().call_deferred("add_child", real)
	real.Init(real.to_local(position), id, crit, self)
	
	
func OnLightningKills():
	OnEnemyKilled.emit()
	weapon_parent.IncreaseLightningKills()
