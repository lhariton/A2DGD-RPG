extends Control

var items_to_load := [
	"res://Scenes/Player/GUI/inventory/resources/sword.tres",
	"res://Scenes/Player/GUI/inventory/resources/shield.tres"
]

func _ready():
	for i in 24:
		var slot := InventorySlot.new()
		slot.init(ItemData.Type.MAIN, Vector2(32,32))
		%Grid.add_child(slot)
	for i in items_to_load.size():
		var item = InventoryItem.new()
		item.init(load(items_to_load[i]))
		%Grid.get_child(i).add_child(item)
		
