extends Item

@onready 
var state_machine = $StateControl
# Called when the node enters the scene tree for the first time.
func _ready():
	item_name = "Shooting Bot"
	item_description = "A bot will follow the player and attack nearby enemies"
	return null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
