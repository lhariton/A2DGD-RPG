extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn()

func spawn():
	$AnimationPlayer.play("Spawn")
	print("chalice!")

