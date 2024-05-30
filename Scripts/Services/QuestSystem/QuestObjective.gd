"""
Base interface should be extended
"""
extends Node
class_name QuestObjective

signal completed_S(objective)
signal updated_S(objective)

var completed : bool = false

func finish() -> void:
	completed = true
	emit_signal("completed_S", self)
	
func as_text() -> String:
	return "Dummy"
