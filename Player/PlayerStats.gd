extends Node
class_name Stats
var rechargeTime: float = 3.0
var baseArmor: float = 9999.0
var maxHealth: float = 100.0
var baseSpeed: float = 600.0
var baseCritChance: float = 0.0
var baseCritDamage: float = 25.0
var baseDamageMod: float = 10.0
var maxExperience: float = 0.0
var maxFuel : float = 100
var maxHealthAllowed = maxHealth
var rechargeRate : float = 15.0
var baseDashCooldown : float = 2.0
var stats : Dictionary[String, float]= {
	"Level" : 1.0,
	"Health" : maxHealth,
	"Base_Damage_Mod": baseDamageMod,
	"Damage_Mod": baseDamageMod,
	"Base_Armor": baseArmor,
	"Armor": baseArmor,
	"Crit_Chance": baseCritChance,
	"Crit_Damage" : baseCritDamage,
	"Speed" : baseSpeed,
	"Fuel" : maxFuel,
	"Recharge_Time" : rechargeTime,
	"Recharge_Rate" : rechargeRate,
	"Dash_Cooldown" : baseDashCooldown
}
signal health_change
signal no_health

func SetHealth(value):
	stats.Health = clamp(stats.Health + value, stats.Health + value, maxHealthAllowed)
	if health_change.get_connections().size() > 0:
		health_change.emit()
	if stats.Health <= 0:
		emit_signal("no_health")
	get_parent().healthBar._set_health(ReturnHealth())
	
func ReturnHealth():
	return stats.Health
	
func SetSpeed(value):
	stats.Speed = value

func ReturnSpeed():
	return stats.Speed

func SetFuel(value):
	stats.Fuel = clamp(stats.Fuel + value, stats.Fuel + value, maxFuel)
	
	
func ReturnMaxFuel():
	return maxFuel
	
func ReturnCurrentFuel():
	return stats.Fuel 
	
func SetBaseDamageMod(amount):
	stats.Base_Damage_Mod += amount
	health_change.emit()
	SetDamageMod(0)
	
func SetDamageMod(amount):
	stats.Damage_Mod += stats.Base_Damage_Mod + amount
	

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
	stats.Recharge_Time += amount
	
func ReturnChargeTime():
	return stats.Recharge_Time

func ReturnBaseDamageMod():
	return stats.Base_Damage_Mod
	
func SetBaseArmorMod(amount):
	stats.Base_Armor += amount
	health_change.emit()
	SetArmor(0)
	
	
func SetArmor(amount):
	stats.Armor = stats.Base_Armor + amount

func ReturnArmor():
	return stats.Armor

func SetRechargeRate(percentage : float):
	rechargeRate += rechargeRate * percentage

func ReturnRechargeRate() -> float:
	return rechargeRate

func SetDashCooldown(amount : float) : 
	stats.Dash_Cooldown += amount

func ReturnDashCooldown() -> float:
	return stats.Dash_Cooldown
	
func LevelUp():
	stats.Base_Armor += 1
	stats.Base_Damage_Mod += 1
	maxHealth += 1
	stats.Health += 1
	stats.Level += 1
