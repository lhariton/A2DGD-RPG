extends CharacterBody2D

@onready var anim_tree = get_node("AnimationTree")

var attacking: bool = false
var alive: bool = true
var health: int = 10
var damage: int = 1

var dashDirection = Vector2(1,0)
var canDash = true
var dashing = false

func dash(delta):
	var input_vector = getInputVector()
	#print(canDash)
	if dashing == false && canDash == true:
		dashing = true
		canDash = false
		self.velocity = input_vector * delta * 200000
		anim_tree.get("parameters/playback").travel("Dash")	
		move_and_slide()
		#print("pressed dash!")
		#await(get_tree().create_timer(1), "cd")
	

func checkIfGameOver():
	var noMonsters = get_tree().get_nodes_in_group("Monster").size()
	#print(noMonsters)
	if noMonsters == 0:
		get_node("../GameWon").game_over()

func getInputVector():
	var input_vector_x = Input.get_action_strength("WalkRight") - Input.get_action_strength("WalkLeft")
	var input_vector_y = Input.get_action_strength("WalkDown") - Input.get_action_strength("WalkUp")
	var input_vector = Vector2(input_vector_x, input_vector_y).normalized()
	
	return input_vector

func _physics_process(delta):
	checkIfGameOver()
	#print(health)
	#resetDash()
	if Input.is_action_just_pressed("Pause"):
		get_node("../Pause").pause()
		
	if Input.is_action_just_pressed("Attack"):
		attacking = true
		anim_tree.get("parameters/playback").travel("Attack")	
			
	if Input.is_action_just_pressed("Dash"):
			dash(delta)
	
	if (attacking == false) and (alive == true) and (dashing == false):
		var input_vector = getInputVector()
		self.velocity = input_vector * delta * 5000
		if input_vector == Vector2.ZERO:
			anim_tree.get("parameters/playback").travel("Idle")
		else:
			anim_tree.get("parameters/playback").travel("Walk")
			anim_tree.set("parameters/Idle/BlendSpace2D/blend_position", input_vector)
			anim_tree.set("parameters/Attack/BlendSpace2D/blend_position", input_vector)
			anim_tree.set("parameters/Walk/BlendSpace2D/blend_position", input_vector)
			anim_tree.set("parameters/Death/BlendSpace2D/blend_position", input_vector)
			anim_tree.set("parameters/Dash/BlendSpace2D/blend_position", input_vector)
		
			
		move_and_slide()
	
	
func resetDash():
	canDash = true
	

func _on_animation_tree_animation_finished(anim_name):
	#print(anim_name)
	if "Attack_" in anim_name:
		attacking = false
	if "Dash_" in anim_name:
		#print("resetDash")
		dashing = false	
		await get_tree().create_timer(1).timeout
		resetDash()
	
		
func hit(damage):
	health -= damage
	if health <=0:
		alive = false
		anim_tree.get("parameters/playback").travel("Death")
		await anim_tree.animation_finished
		get_node("PlayerAnim").queue_free()
		get_node("../GameOver").game_over()
		


func _on_attack_detector_area_body_entered(body):
	if body.is_in_group("Monster"):
		body.hit(damage)

	
