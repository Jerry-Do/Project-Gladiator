extends Biochemical

##Pseudocode
##On colliding with the enemy stun and reduce their v to 0
##Add v to the enemy that is = to negative of the player's v
##Do the same thing to the player but with no stunning

func _ready():
	super()
	duplicate_flag = false
	price = 14
	item_name = "EnemyHop"
	display_name = "Enemy Hop"
	name = item_name
	item_description = "If dash into an enemy, stun them and push both them and the player back"
	if get_parent() == player.get_node("Item"):
		DoJob()
	return null


func _on_area_2d_area_entered(area):
	if area.has_method("TakingDamageForOther") && player.get_node("StateControl/Dash").is_dashing:
		area.SetStatusOther("stun", 99)
		player.SetStatusTrue("stun", 0.25)
		area.get_parent().velocity = Vector2.ZERO
		player.velocity = -player.velocity * 1.75
		
