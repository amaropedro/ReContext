extends Button

@onready var confirmation: CanvasLayer = $"../../../../Confirmation"
@onready var deck_word_list_component: DeckWordList = $"../../../WordList/DeckWordListComponent"

func _process(_delta: float) -> void:
	disabled = deck_word_list_component.is_anything_selected()
	visible = !disabled

func _on_pressed() -> void:
	confirmation.visible = true
