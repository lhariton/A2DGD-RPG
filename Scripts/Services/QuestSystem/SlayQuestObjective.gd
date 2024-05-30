extends QuestObjective
class_name SlayQuestObjective

@export var amount : int
@export var mob : PackedScene

func connect_signal() -> void:
	for enemy in get_tree().get_nodes_in_group("Monster"): 
		enemy.connect("died_S", _on_enemy_died)

func _on_enemy_died(battler) -> void:
	if completed or battler.mobType != mob.resource_name:
		return
	amount -= 1
	emit_signal("updated_S", self)
	if amount == 0 and not completed:
		finish()

func as_text() -> String:
	return "Slay %s %s(s) %s" % [str(amount), mob.instantiate().mobType, "(completed)" if completed else "" ]



