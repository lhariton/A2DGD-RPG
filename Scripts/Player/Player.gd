extends CharacterBody2D

@onready var anim_tree = get_node("AnimationTree")
var attacking: bool = false
var alive: bool = true
var health: int = 100
var damage: int = 2

func _physics_process(delta):
	print(health)
	if Input.is_action_just_pressed("Attack"):
		attacking = true
		anim_tree.get("parameters/playback").travel("Attack")
		
	if (attacking == false) and (alive == true):
		var input_vector_x = Input.get_action_strength("WalkRight") - Input.get_action_strength("WalkLeft")
		var input_vector_y = Input.get_action_strength("WalkDown") - Input.get_action_strength("WalkUp")
		var input_vector = Vector2(input_vector_x, input_vector_y).normalized()
		
		self.velocity = input_vector * delta * 5000
		if input_vector == Vector2.ZERO:
			anim_tree.get("parameters/playback").travel("Idle")
		else:
			anim_tree.get("parameters/playback").travel("Walk")
			anim_tree.set("parameters/Idle/BlendSpace2D/blend_position", input_vector)
			anim_tree.set("parameters/Attack/BlendSpace2D/blend_position", input_vector)
			anim_tree.set("parameters/Walk/BlendSpace2D/blend_position", input_vector)
			anim_tree.set("parameters/Death/BlendSpace2D/blend_position", input_vector)
		move_and_slide()
	

func _on_animation_tree_animation_finished(anim_name):
	if "Attack_" in anim_name:
		attacking = false
		
func hit(damage):
	health -= damage
	if health <=0:
		alive = false
		anim_tree.get("parameters/playback").travel("Death")
		await anim_tree.animation_finished
		self.queue_free()
		


func _on_attack_detector_area_body_entered(body):
	if body.is_in_group("Monster"):
		body.hit(damage)
