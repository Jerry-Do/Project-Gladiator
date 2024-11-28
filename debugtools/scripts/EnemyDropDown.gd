extends Control




func _on_enemy_list_item_clicked(index, at_position, mouse_button_index):
	var enemy_name = $EnemyList.get_item_text(index)
	var path = "res://Enemy/" + enemy_name + ".tscn"
	var enemy = load(path)
	var newEnemy = enemy.instantiate()
	var spawnPos : Vector2 = Vector2.ZERO
	newEnemy.position = Vector2(564,379)
	newEnemy.rotation = rotation
	get_tree().get_first_node_in_group("GameManager").add_child(newEnemy)
