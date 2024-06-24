extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	showQuest1()
		
func showQuest1():
	if Game.quest1Accepted:
		get_node("Quests").text = "Boars Slain: " + str(Game.boars_slain)
	else:
		get_node("Quests").text = "No Quest Active at the moment!"
