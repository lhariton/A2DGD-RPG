extends CanvasLayer

var currentScene

func _on_retry_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	
	
func _ready():
	self.hide()
	

func game_over():
	get_tree().paused = true
	self.show()
