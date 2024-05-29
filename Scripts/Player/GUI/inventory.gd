extends Control

var items_to_load := [
	"res://Scenes/Player/GUI/inventory/resources/sword.tres",
	"res://Scenes/Player/GUI/inventory/resources/shield.tres"
]

func _ready():
	for i in 24:
		var slot := InventorySlot.new()
	for i in items_to_load.size():
		var item = InventoryItem.new()
