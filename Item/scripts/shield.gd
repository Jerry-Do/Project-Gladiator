
extends Item
@export var amount = 0
#var player : Player

func _ready():
	item_description = "Gives the player a shield"
	#player = get_parent().get_parent()
func _process(delta):
	return null
	#player.shield = amount
