extends Area2D

var damage = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.hit(damage)
