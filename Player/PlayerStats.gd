extends Node

var rechargeTime = 3
var maxHealth = 50
var baseSpeed = 600
var baseCritChance = 0
var baseCritDamage = 25
var baseDamageMod = 1
var maxExperience = 0
var maxDashTime = 2
var stats = {
	"Damage_Mod": baseDamageMod,
	"Crit_Chance": baseCritChance,
	"Crit_Damage" : baseCritDamage,
	"Health": maxHealth,
	"Speed" : baseSpeed,
	"Experience": 0,
	"Dash_Time" : maxDashTime,
	 "Recharge_Time" : rechargeTime
}
signal no_health

func SetHealth(value):
	stats.Health += value
	if stats.Health > maxHealth:
		stats.Health = maxHealth
	if stats.Health <= 0:
		emit_signal("no_health")

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
	
func SetDamageMod(amount):
	stats.Damage_Mod += amount

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
