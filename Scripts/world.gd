extends Node2D


@export var boar_scene: PackedScene
@export var ninja_scene: PackedScene

var rng = RandomNumberGenerator.new()
var spawnSpeed:float = 1.0/5.0
var spawnQ: float

# Called when the node enters the scene tree for the first time.
func _ready():
	$ThemeSong.play()
	spawnQ = 1.0

	

func spawnEnemy():
	print("start spawn")
	var boar_s1 = $BoarSpawnPoint1
	var boar_s2 = $BoarSpawnPoint2
	var boar_s3 = $BoarSpawnPoint3
	var boar_s4 = $BoarSpawnPoint4
	
	var ninja_s1 = $NinjaSpawnPoint1
	var ninja_s2 = $NinjaSpawnPoint2
	var ninja_s3 = $NinjaSpawnPoint3
	var ninja_s4 = $NinjaSpawnPoint4
	
	var diceRoll = rng.randi_range(1,8)
	var enemy
	#diceRoll =8
	match diceRoll:
		1: 
			enemy = boar_scene.instantiate()
			enemy.global_position = boar_s1.global_position - Vector2(100,20)
		2: 
			enemy = boar_scene.instantiate()
			enemy.global_position = boar_s2.global_position- Vector2(100,20)
		3: 
			enemy = boar_scene.instantiate()
			enemy.global_position = boar_s3.global_position- Vector2(100,20)
		4: 
			enemy = boar_scene.instantiate()
			enemy.global_position = boar_s4.global_position- Vector2(100,20)
		5: 
			enemy = ninja_scene.instantiate()
			enemy.global_position = ninja_s1.global_position- Vector2(100,20)
		6: 
			enemy = ninja_scene.instantiate()
			enemy.global_position = ninja_s2.global_position- Vector2(100,20)
		7: 
			enemy = ninja_scene.instantiate()
			enemy.global_position = ninja_s3.global_position- Vector2(100,20)
		8: 
			enemy = ninja_scene.instantiate()
			enemy.global_position = ninja_s4.global_position- Vector2(100,20)
	add_child(enemy)
	print("spawned "+enemy.name)
	
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(self.name)
	if "World3" in self.name:
		spawnQ += delta * spawnSpeed
		#print(spawnQ)
		if spawnQ >= 1:
			spawnQ -= 1
			spawnEnemy()
	
