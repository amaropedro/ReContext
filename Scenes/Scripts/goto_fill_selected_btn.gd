extends Button

var FillSelectedDeck = preload("res://Scenes/FillSelectedDeck.tscn")

func _on_pressed() -> void:
	SceneManager.main.render(FillSelectedDeck, false)
