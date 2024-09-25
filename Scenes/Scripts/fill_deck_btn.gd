extends Button

@onready var word_list_component: WordList = $"../../VBoxContainer/WordListComponent"

func _process(_delta: float) -> void:
	disabled = word_list_component.is_anything_selected()

func _on_pressed() -> void:
	word_list_component.fill_deck()
	SceneManager.main.decks._on_pressed()
