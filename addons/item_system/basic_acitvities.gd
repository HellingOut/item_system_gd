extends VBoxContainer

func on_item_switched() -> void:
	queue_free()

func _on_print_hello_pressed() -> void:
	print("Hello")

func _on_show_item_pressed() -> void:
	var item_image = TextureRect.new()
	item_image.texture = InventoryManager.inventory[InventoryManager.current_item].texture
	get_parent().add_child(item_image)
