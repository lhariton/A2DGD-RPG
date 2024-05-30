extends CharacterBody2D

@onready var anim_tree = get_node("AnimationTree")
var SHURIKEN = preload("res://Scenes/Stuff/projectile.tscn")

var invuFrame: bool = false
var attacking: bool = false
var alive: bool = true
var health: int = 15
var damage: int = 1
var defense: int = 0

var walkMS = 5000
var dashMS = 3 * walkMS

var rollVector
var canDash = true
var dashing = false

var inLastLevel = false


func dash(delta):
	#var input_vector = getInputVector()
	#print(canDash)
	if dashing == false && canDash == true:
		dashing = true
		canDash = false
		invuFrame = true
		self.velocity = rollVector * delta * dashMS
		#get_node("PlayerAnim").play("Smoke")
		anim_tree.get("parameters/playback").travel("Dash")	
		#move_and_slide()
		#print("pressed dash!")
		#await(get_tree().create_timer(1), "cd")
	

func checkIfGameOver():
	var noMonsters = get_tree().get_nodes_in_group("Monster").size()
	#print(noMonsters)
	var level = get_node("../LevelWon")
	if level == null:
		level = get_node("../GameWon")
		inLastLevel = true
	if noMonsters == 0:
		if !inLastLevel:
			#pass
			level.game_over()
	#level.game_over()

func getInputVector():
	var input_vector_x = Input.get_action_strength("WalkRight") - Input.get_action_strength("WalkLeft")
	var input_vector_y = Input.get_action_strength("WalkDown") - Input.get_action_strength("WalkUp")
	var input_vector = Vector2(input_vector_x, input_vector_y).normalized()
	
	return input_vector

func _physics_process(delta):
	checkIfGameOver()
	#print(health)
	#resetDash()
	#if Input.is_action_just_pressed("Pause"):
		#get_node("../Pause").pause()
		
	if Input.is_action_just_pressed("Attack"):
		attacking = true
		#if "Ninja" in self.name:
			#$PlayerAnimite.flip_h = true
		anim_tree.get("parameters/playback").travel("Attack")	
			
	if Input.is_action_just_pressed("Dash"):
		dash(delta)
			
	if Input.is_action_just_pressed("Throw"):
		throw()
	
	if (attacking == false) and (alive == true) and (dashing == false):
		var input_vector = getInputVector()
		self.velocity = input_vector * delta * walkMS
		if input_vector == Vector2.ZERO:
			anim_tree.get("parameters/playback").travel("Idle")
		else:
			rollVector = input_vector
			anim_tree.get("parameters/playback").travel("Walk")
			anim_tree.set("parameters/Idle/BlendSpace2D/blend_position", input_vector)
			anim_tree.set("parameters/Attack/BlendSpace2D/blend_position", input_vector)
			anim_tree.set("parameters/Walk/BlendSpace2D/blend_position", input_vector)
			anim_tree.set("parameters/Death/BlendSpace2D/blend_position", input_vector)
			anim_tree.set("parameters/Dash/BlendSpace2D/blend_position", input_vector)
		
			
	move_and_slide()
	
func throw():
	if SHURIKEN:
		var shuriken = SHURIKEN.instantiate()
		get_tree().current_scene.add_child(shuriken)
		shuriken.global_position = self.global_position 
	
		var shuriken_rotation = self.global_position.direction_to(get_global_mouse_position()).angle()
		shuriken.rotation = shuriken_rotation
	
func resetDash():
	canDash = true
	

func _on_animation_tree_animation_finished(anim_name):
	#print(anim_name)
	if "Attack_" in anim_name:
		attacking = false
	if "Dash" in anim_name:
		#print("resetDash")
		self.velocity = Vector2.ZERO
		invuFrame = false
		dashing = false	
		await get_tree().create_timer(1).timeout
		resetDash()
	
		
func hit(damage):
	if !invuFrame:
		$Hurt.play()
		var finalDmg:float
		if defense != 0:
			finalDmg = damage / defense
		else:
			finalDmg = damage
		print(health)
		print(finalDmg)
		health -= finalDmg
		
	if health <=0:
		alive = false
		anim_tree.get("parameters/playback").travel("Death")
		await anim_tree.animation_finished
		get_node("PlayerAnim").queue_free()
		get_node("../GameOver").game_over()
		


func _on_attack_detector_area_body_entered(body):
	if body.is_in_group("Monster"):
		body.hit(damage)

	
func godMode():
	damage *= 2
	defense *= 2
	health = 10
	health *= 2
	walkMS *= 2
	$GodMode.visible = true
	$GodMode.play("Idle")


func _on_player_anim_animation_finished(anim_name):
	if "Smoke" in anim_name:
		#print("resetDash")
		self.velocity = Vector2.ZERO
		dashing = false	
		await get_tree().create_timer(1).timeout
		resetDash()
