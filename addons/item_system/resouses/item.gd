extends Resource
class_name Item

@export var name: String
@export var texture: Texture2D
@export_file("*.gd") var external_script: String
@export var funcs: Array[ItemFunction]
