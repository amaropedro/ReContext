extends Button

func _on_pressed() -> void:
	JsonManager.save_temp_deck()
	SceneManager.main.decks._on_pressed()
