extends CanvasLayer


func _ready():
	self.hide()

func _on_resume_pressed():
	get_tree().paused = false
	self.hide()
	
func pause():
	get_tree().paused = true
	self.show()
