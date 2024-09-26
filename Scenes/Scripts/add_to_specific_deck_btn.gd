extends Button

@onready var word_list_component: WordList = $"../../../WordListComponent"

const addToDeck = preload("res://Scenes/AddWordsToDeck.tscn")

func _process(_delta: float) -> void:
	disabled = word_list_component.is_anything_selected()
	visible = !disabled

func _on_pressed() -> void:
	JsonManager.create_temp_cards(word_list_component.selected)
	SceneManager.main.render(addToDeck, false)
