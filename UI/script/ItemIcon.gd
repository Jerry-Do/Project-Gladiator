extends Container

@export var item : Item
var pop_up_ref
## Called when the node enters the scene tree for the first time.
func instantiate(item_m : Item):
	item = item_m
	%ItemSprite.texture = item.item_sprite.texture
	if item.quantity > 1:
		%Label.show()
		%Label.text = "X" + str(item.quantity)


	


func _on_mouse_entered():
	var pop_up = preload("res://UI/script/ItemPopup.tscn")
	var real = pop_up.instantiate()
	var mouse_pos = get_viewport().get_mouse_position()
	real.position = Vector2(global_position.x + 100,global_position.y)
	pop_up_ref = real
	real.Instantiate(item)
	add_child(real)


func _on_mouse_exited():
	pop_up_ref.queue_free()
