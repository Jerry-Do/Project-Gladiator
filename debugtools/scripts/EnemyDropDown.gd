extends Control




func _on_enemy_list_item_clicked(index, at_position, mouse_button_index):
	var enemy_name = $EnemyList.get_item_text(index)
	var path = "res://Enemy/" + enemy_name + ".tscn"
	var enemy = load(path)
	var newEnemy = enemy.instantiate()
	var spawnPos : Vector2 = Vector2.ZERO
	var ran_no = RandomNumberGenerator.new().randi_range(-100,100)
	newEnemy.position = Vector2(564 + ran_no,379+ ran_no)
	newEnemy.rotation = rotation
	get_tree().get_first_node_in_group("GameManager").get_parent().add_child(newEnemy)
