extends Button

@onready var confirmation: CanvasLayer = $"../../../../.."

func _on_pressed() -> void:
	confirmation.visible = false
