extends Button

const addDeck = preload("res://Scenes/AddDeck.tscn")

func _on_pressed() -> void:
	SceneManager.main.render(addDeck, false)
