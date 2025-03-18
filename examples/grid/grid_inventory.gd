extends CanvasLayer

@onready var grid_container: GridContainer = $GridContainer


func _ready() -> void:
	grid_container.get_child(0).grab_focus()
	setup_slots()

var slot_num: int = 0
func setup_slots():
	for item in InventoryManager.inventory:
		while slot_num < grid_container.get_child_count():
			var slot = grid_container.get_child(slot_num)
			slot_num += 1
			if slot is Button:
				slot.connect("pressed", create_hover_scene.bind(item.scene_on_hover))
				slot.set("icon", item.texture)
				break

func create_hover_scene(scene: PackedScene, parent: Node = self):
	if not scene:
		printerr("Invalid scene provided.")
		return
	var hovered_item_scene = scene.instantiate()
	if not hovered_item_scene:
		printerr("Failed to instantiate scene.")
		return
	hovered_item_scene.tree_exited.connect(_activate_slot)
	parent.add_child(hovered_item_scene)

func _activate_slot():
	if grid_container.get_child_count() > 0:
		grid_container.get_child(0).grab_focus()
