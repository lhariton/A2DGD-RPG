extends CharacterBody2D

var inArea :bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if inArea:
		if Input.is_action_just_pressed("Interact"):
			print("display dialog")


func _on_player_detector_body_entered(body):
	print("press E to interact")
	inArea = true
	


func _on_player_detector_body_exited(body):
	print("xx")
	inArea = false
