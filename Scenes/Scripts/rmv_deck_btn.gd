extends Button

@onready var deck_list: DeckList = $"../../../DeckList"
@onready var confirmation: CanvasLayer = $"../../../../../Confirmation"

func _process(_delta: float) -> void:
	disabled = deck_list.is_anything_selected()
	visible = !disabled

func _on_pressed() -> void:
	confirmation.visible = true
