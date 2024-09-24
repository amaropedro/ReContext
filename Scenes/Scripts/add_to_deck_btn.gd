extends Button

@onready var deck_list: DeckList = $"../../VBoxContainer/DeckList"

func _process(_delta: float) -> void:
	disabled = deck_list.is_anything_selected()

func _on_pressed() -> void:
	deck_list.add_to_selected_decks()
	SceneManager.main.list._on_pressed()
