extends CanvasLayer

var currentScene

	
func switchScene(resPath):
	call_deferred("_deferred_switch_scene", resPath)
	
func _deferred_switch_scene(resPath):
	get_tree().paused = false
	get_tree().change_scene_to_file(resPath)
	

	
func _ready():
	self.hide()
	var root = get_tree().root
	currentScene = root.get_child(root.get_child_count() -1)
	print_debug(currentScene)
	

func game_over():
	get_tree().paused = true
	self.show()


func _on_next_level_pressed():
	if "2" in currentScene.name: 
		print("game won")
		switchScene("res://Scenes/world3.tscn")
	else:
		switchScene("res://Scenes/world2.tscn")
