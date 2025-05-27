extends Node
class_name BlessingManager


var blessings : Dictionary[String,bool] = {
	"Festive" : false,
	"Sales" : false
}
func GiveBlessing():
	get_tree().paused = true
	
	
	var rng = RandomNumberGenerator.new()
	var random_no = rng.randi_range(0,1)
	match random_no:
		0:
			blessings["Festive"] = true
			get_parent().ui.get_node("Blessing").get_node("Name").text = "Blessing: Festive"
			get_parent().ui.get_node("Blessing").get_node("Description").text = "Enemies deal more damage and give more fame on kill"
		1:
			blessings["Sales"] = true
			get_parent().ui.get_node("Blessing").get_node("Name").text = "Blessing: Sales"
			get_parent().ui.get_node("Blessing").get_node("Description").text = "Items cost less"
	await get_tree().create_timer(2).timeout
	%CanvasModulate.hide()
	get_parent().ui.get_node("Blessing").hide()
	get_parent().ui.get_node("Control").show()
	get_tree().paused = false
	return
