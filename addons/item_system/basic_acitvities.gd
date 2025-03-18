extends VBoxContainer

@onready var print_hello: Button = $PrintHello

func _ready() -> void:
	print_hello.grab_focus()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("back"):
		queue_free()

func _on_print_hello_pressed() -> void:
	print("Hello")

func _on_show_item_pressed() -> void:
	var item_image = TextureRect.new()
	get_parent().add_child(item_image)
