extends Button

func _on_pressed() -> void:
	JsonManager.save_temp_card()
	SceneManager.main.home._on_pressed()
