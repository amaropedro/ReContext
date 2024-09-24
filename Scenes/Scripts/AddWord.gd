extends Button

func _on_pressed() -> void:
	JsonManager.save_temp_card()
	SceneManager.main.list._on_pressed()
