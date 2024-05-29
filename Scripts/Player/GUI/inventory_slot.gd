class_name InventorySlot
extends PanelContainer

@export var type: ItemData.Type
var player

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]

func init(t: ItemData.Type, cms: Vector2) -> void:
	type = t
	custom_minimum_size = cms
	
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is InventoryItem:
		if type == ItemData.Type.MAIN:
			if get_child_count() == 0:##empty slot
				return true
			else:
				if type == data.get_parent().type:##if type matches slot (sword goes in hand etc)
					return true
				return get_child(0).data.type == data.data.type
		else:
			return data.data.type == type
	return false
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	if get_child_count() > 0:##item already in slot
		var item := get_child(0)
		player.damage -= item.data.item_damage
		player.defense -= item.data.item_defense
		if item == data:
			return
		item.reparent(data.get_parent())##switches items
		
	if type != ItemData.Type.MAIN:##equiping something
		player.damage += data.data.item_damage
		player.defense += data.data.item_defense
	else:
		player.damage -= data.data.item_damage
		player.defense -= data.data.item_defense
	data.reparent(self)
		

