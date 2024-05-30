extends CharacterBody2D

var inArea :bool = false

const dialogLines : Array[String] = [ "Hei, da-mi voie sa te ajut!",
										"Uite un scut si o sabie",
										"Apasa ESC, intra in inventar si echipeaza-le"
									 ] 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if inArea:
		if Input.is_action_just_pressed("Interact"):
			DialogManager.start_dialog(global_position, dialogLines)


func _on_player_detector_body_entered(body):
	print("press E to interact")
	inArea = true
	


func _on_player_detector_body_exited(body):
	print("xx")
	inArea = false
