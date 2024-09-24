extends Button

@onready var deck_select_btn: DecKSelectBtn = $"../../VBoxContainer/DeckSelectBtn"

func _process(_delta: float) -> void:
	disabled = !deck_select_btn.is_anything_selected()

func _on_pressed() -> void:
	deck_select_btn.add_to_selected_decks()
	SceneManager.main.list._on_pressed()
