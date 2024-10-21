extends Control

const ChangeKey = preload("res://Scenes/ChangeKey.tscn")

func _on_button_pressed() -> void:
	SceneManager.main.render(ChangeKey)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
