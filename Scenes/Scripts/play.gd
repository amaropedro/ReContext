extends Control

@onready var canvas_layer: CanvasLayer = $CanvasLayer

func _ready() -> void:
	canvas_layer.visible = JsonManager.get_all_cards().is_empty()

func _on_add_syn_pressed() -> void:
	SceneManager.main.add._on_pressed()
