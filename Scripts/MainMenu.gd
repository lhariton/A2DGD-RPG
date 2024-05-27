extends Node


func _ready():
	$Drums.play()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")


func _on_quit_pressed():
	get_tree().quit()
