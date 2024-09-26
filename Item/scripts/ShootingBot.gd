extends Item



func _ready():
	item_name = "ShootingBot"
	display_name = "Shooting Bot"
	item_description = "A bot will follow the player and attack with the player"
	if get_parent() == player.get_child(6):
		var robot_scene = preload("res://Item/ShootingBotActual.tscn")
		var actual_robot = robot_scene.instantiate()
		player.get_child(6).add_child(actual_robot)
		get_parent().remove_child(self)
