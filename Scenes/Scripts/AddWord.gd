extends Button

@onready var synonym: CanvasLayer = $"../../../../Synonym"

func _on_pressed() -> void:
	disabled = true
	synonym.visible = true
