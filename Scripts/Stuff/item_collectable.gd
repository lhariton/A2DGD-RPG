extends StaticBody2D

var inArea :bool = false
var player

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	spawn()

func spawn():
	$AnimationPlayer.play("Spawn")
	print("chalice!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if inArea:
		if Input.is_action_just_pressed("Interact"):
			player.godMode()
			queue_free()


func _on_item_player_detector_body_entered(body):
	print("press E to collect challice")
	inArea = true
	


func _on_item_player_detector_body_exited(body):
	print("left chalice area")
	inArea = false



func _on_animation_player_animation_finished(anim_name):
	if "Spawn" in anim_name:
		$AnimatedSprite2D.play("Idle")
