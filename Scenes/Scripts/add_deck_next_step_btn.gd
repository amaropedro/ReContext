extends Button

const fillDeck = preload("res://Scenes/FillDeck.tscn")

@onready var deck_name: LineEdit = $"../../VBoxContainer/DeckName"

func _on_pressed() -> void:
	JsonManager.create_temp_deck(deck_name.text)
	SceneManager.main.render(fillDeck, false)

func _process(_delta: float) -> void:
	disabled = deck_name.text == ""
