extends Node

var rechargeTime = 3
var baseArmor = 3
var maxHealth = 50
var baseSpeed = 600
var baseCritChance = 0
var baseCritDamage = 25
var baseDamageMod = 10
var maxExperience = 0
var maxDashTime = 2
var maxHealthAllowed = maxHealth
var stats = {
	"Base_Damage_Mod": baseDamageMod,
	"Damage_Mod": baseDamageMod,
	"Base_Armor": baseArmor,
	"Armor": baseArmor,
	"Crit_Chance": baseCritChance,
	"Crit_Damage" : baseCritDamage,
	"Health": maxHealth,
	"Speed" : baseSpeed,
	"Experience": 0,
	"Dash_Time" : maxDashTime,
	"Recharge_Time" : rechargeTime
}
signal health_change
signal no_health

func SetHealth(value):
	stats.Health += value
	if health_change.get_connections().size() > 0:
		health_change.emit()
	if stats.Health > maxHealthAllowed:
		stats.Health = maxHealthAllowed
	if stats.Health <= 0:
		emit_signal("no_health")
	get_parent().healthBar._set_health(ReturnHealth())
	
func ReturnHealth():
	return stats.Health
	
func SetSpeed(value):
	stats.Speed = value

func ReturnSpeed():
	return stats.Speed

func SetDashTime(value):
	stats.Dash_Time += value
	
func ReturnMaxDashTime():
	return maxDashTime
	
func ReturnCurrentDashTime():
	return stats.Dash_Time 
	
func SetBaseDamageMod(amount):
	stats.Base_Damage_Mod += amount
	SetDamageMod(0)
	
func SetDamageMod(amount):
	stats.Damage_Mod = stats.Base_Damage_Mod + amount

func ReturnDamageMod():
	return stats.Damage_Mod

func SetCritDamage(amount):
	stats.Crit_Damage += amount

func ReturnCritDamage():
	return stats.Crit_Damage
	
func SetCritChance(amount):
	stats.Crit_Chance += amount
	
func ReturnCritChance():
	return stats.Crit_Chance

func SetChargeTime(amount):
	rechargeTime += amount
	
func ReturnChargeTime():
	return rechargeTime

func ReturnBaseDamageMod():
	return stats.Base_Damage_Mod
	
func SetBaseArmorMod(amount):
	stats.Base_Armor += amount
	SetArmor(0)
	
func SetArmor(amount):
	stats.Armor = stats.Base_Armor + amount

func ReturnArmor():
	return stats.Armor
