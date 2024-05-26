extends Control

var player

var playerHp
var playerDmg
var playerDef

func getPlayerValue():
	player = get_tree().get_nodes_in_group("Player")[0]
	playerHp = player.health
	playerDmg = player.damage
	playerDef = player.defense
	
# Called when the node enters the scene tree for the first time.
func _ready():
	#getPlayerValue()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	getPlayerValue()
	get_node("stats_label").text = "Player Health: %s\nAttack: %s\nDefense: %s\n" % [playerHp,playerDmg,playerDef]
