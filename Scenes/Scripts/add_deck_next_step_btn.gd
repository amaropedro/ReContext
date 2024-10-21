extends Button

const fillDeck = preload("res://Scenes/FillDeck.tscn")

@onready var deck_name: LineEdit = $"../../../Panel/VBoxContainer/DeckName"

func _on_pressed() -> void:
	JsonManager.new_deck(deck_name.text)
	JsonManager.create_temp_deck(deck_name.text)
	SceneManager.main.render(fillDeck, false)

func _process(_delta: float) -> void:
	disabled = deck_name.text == ""
