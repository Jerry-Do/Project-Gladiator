extends Control

@export var items : Array
@onready var item_sprite = $ItemSprite
@onready var description = $Description
# Called when the node enters the scene tree for the first time.
func _ready():
	var item = load(items[0])
	var newItem = item.instantiate()
	add_child(newItem)
	
	var child = get_child(3)
	child.item_sprite.hide()
	item_sprite.texture = child.ReturnItemSprite()
	description.text = child.ReturnItemDescription()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
