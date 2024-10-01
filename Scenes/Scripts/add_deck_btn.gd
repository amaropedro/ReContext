extends Button

@export var is_selected: bool = false

func _on_pressed() -> void:
	if is_selected:
		SceneManager.main.load_render("res://Scenes/ManageDeck.tscn")
		return
	
	JsonManager.save_temp_deck()
	SceneManager.main.decks._on_pressed()
