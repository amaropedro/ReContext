extends Button

@onready var deck_list: DeckList = $"../../../DeckListPanel/DeckList"

const manageDeck = preload("res://Scenes/ManageDeck.tscn")

func _process(_delta: float) -> void:
	visible = !deck_list.is_anything_selected()
	disabled = !deck_list.is_only_one_selected()

func _on_pressed() -> void:
	SceneManager.deckToManage = deck_list.selected[0]
	SceneManager.main.render(manageDeck, false)
