extends Button

@onready var word_list_component: WordList = $"../../../../../../VBoxContainer/WordList/WordListComponent"

func _on_pressed() -> void:
	word_list_component.remove_selected_cards_from_all()
	SceneManager.main.list._on_pressed()
