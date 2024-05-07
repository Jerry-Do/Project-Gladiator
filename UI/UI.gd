extends CanvasLayer
class_name  UI

@onready var healthLabel = %Health
@onready var ammoLabel = %Ammo
@onready var fameLabel = %Fame
@onready var fameMultiLabel = %FameMultiplier
@onready var fameMultiTimerLabel = %FameMultiTimer
@onready var stats = PlayerStats

	
func update_health_text(value):
	healthLabel.text = "Health: " + str(value)
	
func update_ammo_text(value):
	ammoLabel.text = "Ammo: " + str(value)

func update_fame_text(currentFame, newMaxFame):
	fameLabel.text = "Fame: " + str(currentFame) + " / " + str(newMaxFame)

func update_fameMulti_text(value):
	var formatString = "%f"
	var actualString = formatString % value
	fameMultiLabel.text = "Fame Multiplier: " + str(actualString)

func update_fameMultiTimer_text(value):
	fameMultiTimerLabel.text = "Timer: " + str(value)
