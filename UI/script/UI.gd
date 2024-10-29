extends CanvasLayer
class_name  UI

#@onready var healthLabel = %Health
@onready var ammoLabel = %Ammo
@onready var killLabel = %Kill
@onready var fameMultiLabel = %FameMultiplier
@onready var fameMultiTimerLabel = %FameMultiTimer
@onready var WeaponTimerLabel = %WeaponTimerText
@onready var itemSprite = %ItemSprite
@onready var newWeaponAlert = %NewWeaponAlert
@onready var timerText = %TimerText
@onready var stats = PlayerStats
@onready var fameLabel = %Fame

func update_fame_text(currentFame):
	fameLabel.text = "Fame: " + str(currentFame) 

	
func update_ammo_text(value):
	ammoLabel.text = "Ammo: " + str(value)

func update_kill_text(currentKill, newMaxKill):
	killLabel.text = "Kill: " + str(currentKill) + " / " + str(newMaxKill)

func update_fameMulti_text(value):
	fameMultiLabel.text = "Fame Multiplier: " + FormatString(value, "%.2f")

func update_fameMultiTimer_text(value):
	
	fameMultiTimerLabel.text = "Timer: " + FormatString(value, "%.2f")

func update_WeaponTimer_text(value):
	WeaponTimerLabel.text = "Weapon Timer: " + FormatString(value, "%d")

func update_item_sprite(spritePath):
	if spritePath:
		itemSprite.texture = load(spritePath)
	else:
		itemSprite.texture = null

func set_new_weapon_alert_visibility(flag):
	newWeaponAlert.visible = flag
	
func set_new_weapon_timer_alert_visibility(flag):
	%WeaponTimer.visible = flag
	
func FormatString(value, format : String) -> String:
	var formatString = format
	var actualString = formatString % value
	return actualString

func set_timer(value):
	timerText.text = "Time: " + FormatString(value, "%d")
