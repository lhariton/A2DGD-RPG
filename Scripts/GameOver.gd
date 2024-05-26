extends CanvasLayer


func _on_retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	
func _ready():
	self.hide()


func game_over():
	get_node("../GUI").hide()
	get_tree().paused = true
	self.show()
