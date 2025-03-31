
extends Biochemical
@export var dmg_amount = 1
@export var evo_amount = 0
@onready var timer = $Timer
var health_regened = 0
var active : bool = false


func _ready():
	super()
	active = true
	duplicate_flag = false
	price = 20
	item_name = "LeechSeed"
	display_name = "Leech Seed"
	name = item_name
	item_description = "After certain seconds, infuse the next shot with the leech seed. " +\
	"The leech seed damage the enemy over time, and heals the player for the same amount. After evolving, if the " + \
	"enemy dies while the seed is still active, a tree will be spawn at the position, and start to emitting posion gas"
	evolve_condition_text = "Kill " + str(evo_amount) + " enemies while the seed is still active"
	return null

func StartCooldown():
	active = false
	$Timer.start()

func _on_timer_timeout():
	active = true
	
func UpdateDescription():
	item_description = "After " + str(timer.wait_time) + " seconds, infuse the next shot with the leech seed. " +\
	"The leech seed damage the enemy over time, and heals the player for the same amount. After evolving, if the " + \
	"enemy dies while the seed is still active, a tree will be spawn at the position, and start to emitting posion gas"
