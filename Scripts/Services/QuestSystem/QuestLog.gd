extends Node

@onready var available_quests = $Available
@onready var active_quests = $Active
@onready var completed_quests = $Completed
@onready var db = $DataBase

func find_available_quest_by_ID(id: String) -> Quest:
	for quest : Quest in available_quests.get_children():
		if quest.ID == id:
			return quest
	return null

func find_available(reference: Quest) -> Quest:
	return available_quests.find(reference)

func get_available_quests() -> Array:
	return available_quests.get_children()
	
func is_available(reference: Quest) -> bool:
	return available_quests.find(reference) != null

func start( reference : Quest ):
	var quest : Quest = available_quests.find(reference)
	quest.connect("completed", _on_Quest_Completed)
	available_quests.remove_child(quest)
	active_quests.add_child(quest)
	quest._start()
	
func _on_Quest_Completed(quest : Quest):
	active_quests.remove_child(quest)
	completed_quests.add_child(quest)
	








