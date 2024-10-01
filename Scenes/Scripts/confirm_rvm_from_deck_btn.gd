extends Button

@onready var deck_word_list_component: DeckWordList = $"../../../../../../VBoxContainer/WordList/DeckWordListComponent"
@onready var confirmation: CanvasLayer = $"../../../../.."
@onready var manage_deck: Control = $"../../../../../.."

func _on_pressed() -> void:
	deck_word_list_component.remove_selected_cards_from_deck()
	confirmation.visible = false
	SceneManager.main.reload("res://Scenes/ManageDeck.tscn")
