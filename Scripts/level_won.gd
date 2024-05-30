extends CanvasLayer

var currentScene

func _on_retry_pressed():
	get_tree().paused = false
	if "2" in currentScene.name: 
		switchScene("res://Scenes/world3.tscn")
	else:
		switchScene("res://Scenes/world2.tscn")
	
func switchScene(resPath):
	call_deferred("_deferred_switch_scene", resPath)
	
func _deferred_switch_scene(resPath):
	currentScene.free()
	var s = load(resPath)
	currentScene = s.instantiate()
	get_tree().root.add_child(currentScene)
	get_tree().current_scene = currentScene
	
func _ready():
	self.hide()
	var root = get_tree().root
	currentScene = root.get_child(root.get_child_count() -1)
	print_debug(currentScene)
	

func game_over():
	get_tree().paused = true
	self.show()
