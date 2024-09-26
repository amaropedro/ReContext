extends Button

@onready var word_list_component: WordList = $"../../../WordListComponent"

func _process(_delta: float) -> void:
	disabled = word_list_component.is_anything_selected()
	visible = !disabled

func _on_pressed() -> void:
	word_list_component.remove_selected_cards_from_all()
	SceneManager.main.list._on_pressed()
