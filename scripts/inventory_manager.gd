extends Control

@export var inventory: Array[Item]
@onready var items_container: VBoxContainer = $HBoxContainer/Items
@onready var actions: VBoxContainer = $HBoxContainer/Actions

signal item_switched
var hovered_item_scene: Node

var items_labels: Array[Label]
var current_item: int = 0:
	set(value):
		item_switched.emit()
		items_labels[current_item].modulate = Color.WHITE
		current_item = value
		items_labels[current_item].modulate = Color.YELLOW
		create_hover_scene(inventory[current_item])

func _ready() -> void:
	for item in inventory:
		items_labels.append(Label.new())
		items_labels[inventory.find(item)].text = item.name
		items_container.add_child(items_labels[inventory.find(item)])

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_up") and current_item > 0:
		current_item -= 1
	elif Input.is_action_just_pressed("ui_down") and current_item < inventory.size() - 1:
		current_item += 1

func create_hover_scene(item: Item):
	hovered_item_scene = item.scene_on_hover.instantiate()
	if hovered_item_scene.has_method("on_item_switched"):
		item_switched.connect(hovered_item_scene.on_item_switched)
	actions.add_child(hovered_item_scene)
