extends Button

@onready var deck_list: DeckList = $"../../../../../../VBoxContainer/DeckListPanel/DeckList"

func _on_pressed() -> void:
	deck_list.del_selected_decks()
	SceneManager.main.decks._on_pressed()
