extends Control

@onready var deck_name: LineEdit = $VBoxContainer/Panel/VBoxContainer/DeckName
@onready var create_deck_btn: Button = $VBoxContainer/HBoxContainer2/AddDeckBtn/CreateDeckBtn

func _on_create_deck_btn_pressed() -> void:
	JsonManager.new_deck(deck_name.text)
	SceneManager.main.decks._on_pressed()

func _process(_delta: float) -> void:
	create_deck_btn.disabled = deck_name.text == ""
