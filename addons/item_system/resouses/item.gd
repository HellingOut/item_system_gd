extends Resource
class_name Item

@export var name: String
@export var texture: Texture2D
@export var scene_on_hover: PackedScene = preload("res://addons/item_system/basic_acitvities.tscn")
