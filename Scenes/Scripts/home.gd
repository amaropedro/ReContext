extends Control

const ChangeKey = preload("res://Scenes/ChangeKey.tscn")

func _on_button_pressed() -> void:
	SceneManager.main.render(ChangeKey)
