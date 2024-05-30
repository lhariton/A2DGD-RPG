extends Area2D

var speed: int = 1000
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta

func destroy():
	queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Monster"):
		body.hit(5)
	#destroy()
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	destroy()
