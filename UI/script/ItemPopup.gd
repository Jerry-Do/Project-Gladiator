extends PopupPanel


# Called when the node enters the scene tree for the first time.
func Instantiate(item:Item):
	%ItemName.text = item.ReturnDisplayName()
	%Description.text = item.ReturnItemDescription()
