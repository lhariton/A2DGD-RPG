extends Node2D


var state = "closed" #closed/open
var player_in_area = false
var item = preload("res://Scenes/Stuff/item_collectable.tscn")

func _ready():
	pass
	
func _process(delta):
	if state == "closed":
		$AnimatedSprite2D.play("Idle")
		if player_in_area:
			if Input.is_action_just_pressed("Interact"):
				state = "open"
				drop_item()
	if state == "open":
		$AnimatedSprite2D.play("Open")
		
		
		
func drop_item():
	var item_instance = item.instantiate()
	item_instance.global_position = $Marker2D.global_position
	var world = get_parent()
	world.add_child(item_instance)
	
	
func _on_pickable_area_body_entered(body):
	if body.is_in_group("Player"):
		player_in_area = true

func _on_pickable_area_body_exited(body):
	if body.is_in_group("Player"):
		player_in_area = false


func _on_animated_sprite_2d_animation_finished():
	if state == "open":
		state = "perma_open"
		$AnimatedSprite2D.play("Stay Open")
