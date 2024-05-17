extends CanvasLayer
class_name  UI

@onready var healthLabel = %Health
@onready var ammoLabel = %Ammo
@onready var fameLabel = %Fame
@onready var fameMultiLabel = %FameMultiplier
@onready var fameMultiTimerLabel = %FameMultiTimer
@onready var WeaponTimerLabel = %WeaponTimer
@onready var itemSprite = %ItemSprite
@onready var newWeaponAlert = %NewWeaponAlert
@onready var stats = PlayerStats
	
func update_health_text(value):
	healthLabel.text = "Health: " + str(value)
	
func update_ammo_text(value):
	ammoLabel.text = "Ammo: " + str(value)

func update_fame_text(currentFame, newMaxFame):
	fameLabel.text = "Fame: " + str(currentFame) + " / " + str(newMaxFame)

func update_fameMulti_text(value):
	fameMultiLabel.text = "Fame Multiplier: " + str(FormatString(value, "%.2f"))

func update_fameMultiTimer_text(value):
	
	fameMultiTimerLabel.text = "Timer: " + str(FormatString(value, "%.2f"))

func update_WeaponTimer_text(value):
	FormatString(value, "%d")
	WeaponTimerLabel.text = "Weapon Timer: " + str(FormatString(value, "%d"))

func update_item_sprite(spritePath):
	if spritePath:
		itemSprite.texture = load(spritePath)
	else:
		itemSprite.texture = null

func set_new_weapon_alert_visibility(flag):
	newWeaponAlert.visible = flag

func FormatString(value, format : String):
	var formatString = format
	var actualString = formatString % value
	return actualString
