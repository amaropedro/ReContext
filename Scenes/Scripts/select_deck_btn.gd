extends Button

@onready var deck_list: DeckList = $"../../../DeckListPanel/DeckList"

func _process(_delta: float) -> void:
	disabled = !deck_list.is_only_one_selected()

func _on_pressed() -> void:
	SceneManager.selectedDeck = deck_list.selected[0]
	SceneManager.main.render(SceneManager.selectedGame, false)
