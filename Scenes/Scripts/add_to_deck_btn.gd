extends Button

@onready var deck_list: DeckList = $"../../VBoxContainer/DeckList"
@onready var synonym: CanvasLayer = $"../../../../Synonym"

func _process(_delta: float) -> void:
	disabled = deck_list.is_anything_selected()

func _on_pressed() -> void:
	disabled = true
	synonym.visible = true
