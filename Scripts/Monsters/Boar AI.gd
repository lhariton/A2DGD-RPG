extends CharacterBody2D

@export var player: CharacterBody2D
var speed: int = 2500
var damage: int = 3
var health: int = 10
@onready var anim = get_node("Anim")
@onready var hitDetector = get_node("HitDetector/CollisionShape2D")

signal died_S(Boar)
@export var mobType = "Boar AI"

enum mobState {
	IDLE, CHASING, ATTACKING, DEAD
}

var current_state

func _ready():
	current_state = mobState["IDLE"]
	if player == null:
		player = get_tree().get_nodes_in_group("Player")[0]

func _physics_process(delta):
	if is_instance_valid(player):
		var direction = (player.global_position - self.global_position).normalized()
		
		match current_state:
			mobState["IDLE"]:
				anim.play("Idle")
				velocity = Vector2(0,0)
			mobState["CHASING"]:
				anim.play("Move")
				velocity = direction * speed * delta
			mobState["ATTACKING"]:
				anim.play("Attack")
				velocity = Vector2(0,0)
			mobState["DEAD"]:
				velocity = Vector2(0,0)
				$AnimationPlayer.play("Death")
				await $AnimationPlayer.animation_finished
				self.queue_free()
	
				
		if direction.x < 0:
			anim.flip_h = true
			hitDetector.position = Vector2(-17, 7)
		else:
			anim.flip_h = false
			hitDetector.position = Vector2(17, 7)
		move_and_slide()
	
		

func hit(damage):
	health -= damage
	$Hurt.play()
	if health <=0:
		current_state = mobState["DEAD"]
		#emit_signal("died_S", self)

func _on_player_detector_body_entered(body):
	if body.is_in_group("Player"):
		current_state = mobState["CHASING"]
		
func _on_player_detector_body_exited(body):
	if body.is_in_group("Player"):
		current_state = mobState["IDLE"]


func _on_attack_detector_body_entered(body):
	if body.is_in_group("Player"):
		current_state = mobState["ATTACKING"]
		
func _on_attack_detector_body_exited(body):
	if body.is_in_group("Player"):
		current_state = mobState["CHASING"]


func _on_hit_detector_body_entered(body):
	if body.is_in_group("Player"):
		body.hit(damage)


func _on_anim_frame_changed():
	if current_state == mobState["ATTACKING"]:
		if anim.frame == 1:
			hitDetector.disabled = false
		if anim.frame == 2:
			hitDetector.disabled = true
