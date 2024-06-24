extends Area2D


@onready var label = get_node("Panel/RichTextLabel")
@onready var panel = get_node("Panel")
signal finishedDialogue()
signal LineChangedDialogue(currentLine)
var currentLine: int = 0
@export var Story_text: PackedStringArray
@onready var timer = get_node("Timer")

func _ready():
	panel.hide()

func type():
	#get_tree().paused = true
	if currentLine < Story_text.size():
		var lines = round((Story_text[currentLine].length())/15)
		var timeLength = round((Story_text[currentLine].length())/10)
		label.text = ""
		label.visible_ratio = 0
		var tween = create_tween()
		label.text = "[center]"+ Story_text[currentLine] + "[/center]"
		tween.tween_property(label, "visible_ratio", 1, timeLength)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_callback(startTimer)
		
		panel.position.y -= lines * 2
		panel.size.y = label.size.y + lines * 4 + 5
	else: 
		finish()

func _on_timer_timeout():
	currentLine += 1
	timer.stop()
	type()

func startTimer():
	timer.start()
	
func finish():
	panel.hide()
	label.hide()
	#get_tree().paused = false
	finishedDialogue.emit()
	Game.cutSceneCurrent = false
	
	Game.quest1Accepted = true

func _on_body_entered(body):
	if body.is_in_group("Player"):
		panel.show()
		type()
		Game.cutSceneCurrent = true
