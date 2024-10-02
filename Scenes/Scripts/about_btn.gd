extends Node

@onready var main: Control = $".."
const about = preload("res://Scenes/About.tscn")

func _on_pressed() -> void:
	main.render(about)
