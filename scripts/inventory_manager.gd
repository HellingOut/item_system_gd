extends Control

@export var inventory: Array[Item]
@onready var items_container: VBoxContainer = $HBoxContainer/Items
@onready var actions: VBoxContainer = $HBoxContainer/Actions

@onready var executor: Node = $Executor

var items_labels: Array[Label]
var current_item: int = 0:
	set(value):
		items_labels[current_item].modulate = Color.WHITE
		current_item = value
		create_buttons(value)


func _ready() -> void:
	for item in inventory:
		items_labels.append(Label.new())
		items_labels[inventory.find(item)].text = item.name
		items_container.add_child(items_labels[inventory.find(item)])
	create_buttons(current_item)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_up") and current_item > 0:
		current_item -= 1
	elif Input.is_action_just_pressed("ui_down") and current_item < inventory.size() - 1:
		current_item += 1

func create_buttons(index: int = 0):
	for child: Node in actions.get_children():
		child.queue_free()
	
	var script = load(inventory[index].external_script)
	
	if script is Script:
		executor.set_script(load(inventory[index].external_script))
	else:
		printerr("Failed to load sctipt ", inventory[index].external_script)
	
	items_labels[index].modulate = Color.YELLOW

func _on_executor_script_changed() -> void:
	for function: ItemFunction in inventory[current_item].funcs:
		var btn: Button = Button.new()
		btn.text = function.name
		btn.icon = function.icon
		actions.add_child(btn)
		
		if executor.has_method(function.callable_name):
			btn.connect(
				"pressed",
				func():
					if function.args:
						executor.call(function.callable_name, function.args)
					else:
						executor.call(function.callable_name)
			)
		else:
			printerr("Cannot find function ", function.callable_name)
