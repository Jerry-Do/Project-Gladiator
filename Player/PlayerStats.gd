extends Node

var maxHealth = 10
var baseSpeed = 600
var baseCritChance = 0
var baseCritDamage = 0
var maxExperience = 0
var dashTime = 2
var stats = {
	"Health": maxHealth,
	"CritChance": baseCritChance,
	"Speed" : baseSpeed,
	"CritDamage": baseCritDamage,
	"Experience": 0,
	"DashTime" : dashTime
}
signal no_health


	
	
	
func SetHealth(value):
	stats.Health += value
	if stats.Health <= 0:
		emit_signal("no_health")

func ReturnHealth():
	return stats.Health
	
func SetSpeed(value):
	stats.Speed = value

func ReturnSpeed():
	return stats.Speed

func SetCritChance(value):
	stats.CritChance += value

func ReturnCritChance():
	return stats.CritChance

func SetCritDamage(value):
	stats.CritDamage += value

func ReturnCritDamage():
	return stats.CritDamage

func SetDashTime(value):
	stats.DashTime += value
	
func ReturnMaxDashTime():
	return dashTime
	
func ReturnCurrentDashTime():
	return stats.DashTime 
