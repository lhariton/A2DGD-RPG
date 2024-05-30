extends CanvasLayer


func _ready():
	hideGUI()
	$Container/VBoxContainer/Profile.disabled = true
	$Container/Profile.show()
	$hp_bar.max_value = get_node("../Player").health
	get_node("Container").hide()


func _process(delta):
	$hp_bar.value = get_node("../Player").health
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = !get_tree().paused
		get_node("Container").visible = get_tree().paused


func hideGUI():
	$Container/VBoxContainer/Profile.disabled = false
	$Container/VBoxContainer/Inventory.disabled = false
	$Container/VBoxContainer/Quests.disabled = false
	$Container/Profile.hide()
	$Container/Inventory.hide()
	$Container/Quests.hide()
	$DialogContainer.hide()

func _on_profile_pressed():
	hideGUI()
	$Container/VBoxContainer/Profile.disabled = true
	$Container/Profile.show()

func _on_inventory_pressed():
	hideGUI()
	$Container/VBoxContainer/Inventory.disabled = true
	$Container/Inventory.show()


func _on_quests_pressed():
	hideGUI()
	$Container/VBoxContainer/Quests.disabled = true
	$Container/Quests.show()


func _on_button_pressed():
	hideGUI()
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

