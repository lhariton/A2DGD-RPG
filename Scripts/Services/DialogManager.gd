extends Node

@onready var dialogScence = preload("res://Scenes/Player/GUI/dialog.tscn")

var dialogLines: Array[String] = []
var currentLineIndex = 0

var dialog
var dialogPosition: Vector2

var isDialogActive = false
var canAdvanceLine = false

var timer
const HIDE_DIALOG_TIME = 5


func start_dialog(position: Vector2, lines: Array[String]):
	if isDialogActive:
		return
	dialogLines = lines
	dialogPosition = position
	_show_dialog()
	isDialogActive = true
	
func _show_dialog():
	dialog = dialogScence.instantiate()
	dialog.finished_displaying.connect(_on_dialog_finished_displaying)
	get_tree().root.add_child(dialog)
	
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_dialog_hide_timeout)
	get_tree().root.add_child(timer)
	
	dialog.global_position = dialogPosition
	dialog.displayText(dialogLines[currentLineIndex])
	canAdvanceLine = false
	
func _on_dialog_finished_displaying():
	canAdvanceLine = true
	timer.start(HIDE_DIALOG_TIME)
	

func _unhandled_input(event):
	if ( 
		event.is_action_pressed("advance_dialog") &&
		isDialogActive &&
		canAdvanceLine
	):
		dialog.queue_free()
		timer.stop()
		timer.queue_free()
		currentLineIndex += 1
		if currentLineIndex >= dialogLines.size():
			isDialogActive = false
			currentLineIndex = 0
			return
			
		_show_dialog()

func _on_dialog_hide_timeout():
	if (isDialogActive && canAdvanceLine):
		dialog.queue_free()
		timer.queue_free()
		currentLineIndex += 1
		
		if currentLineIndex >= dialogLines.size():
			isDialogActive = false
			currentLineIndex = 0
			return
			
		_show_dialog()
