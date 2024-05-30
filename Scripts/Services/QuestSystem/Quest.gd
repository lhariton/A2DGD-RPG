extends Node
class_name  Quest

signal started()
signal completed(Quest)
signal delivered()

@onready var objectives : Node = $Objectives

@export var title : String
@export var description : String
@export var ID : String
@export var reward_on_delivery : bool = false
@export var _reward_experience : int
@onready var _reward_items : Node = $ItemRewards

func _start():
	for objective in get_objectives():
		objective.connect("completed_S", _on_Objective_Completed)
		if objective is SlayQuestObjective:
			(objective as SlayQuestObjective).connect_signal()
		emit_signal("started")

func get_objectives():
	return objectives.get_children()

func get_completed_objectives():
	var completed : Array = []
	for objective in get_objectives():
		if not objective.completed:
			continue
		completed.append(objective)
	return completed

func _on_Objective_Completed(objective) -> void:
	if get_completed_objectives().size() == get_objectives().size:
		emit_signal(objective)

func _deliver():
	emit_signal("delivered")

func _notify_slay_objectives() -> void:
	for objective in get_objectives():
		if not objective is SlayQuestObjective:
			continue
		(objective as SlayQuestObjective).connect_signal()
		
func get_rewards() -> Dictionary:
	return {
		'exp' : _reward_experience,
		'items' : _reward_items.get_children()
	}

func get_rewards_as_text() -> Array:
	var text = []
	text.append(" - Exp: %s" % str(_reward_experience))
	for item in _reward_items.get_children():
		text.append(" - [%s] x (%s)" % [item.item.name, str(item.amount)])
	return text


