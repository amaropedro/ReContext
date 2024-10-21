extends Button

@onready var word_list_component: WordList = $"../../../Panel/VBoxContainer/WordListComponent"

@export var is_selected: bool = false

func _process(_delta: float) -> void:
	disabled = word_list_component.is_anything_selected()

func _on_pressed() -> void:
	word_list_component.fill_deck()
	
	if is_selected:
		SceneManager.main.load_render("res://Scenes/ManageDeck.tscn")
		return
	
	SceneManager.main.decks._on_pressed()
