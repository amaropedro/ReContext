extends Button

@onready var word_list_component: WordList = $"../../../WordList/WordListComponent"
@onready var confirmation: CanvasLayer = $"../../../../Confirmation"

func _process(_delta: float) -> void:
	disabled = word_list_component.is_anything_selected()
	visible = !disabled

func _on_pressed() -> void:
	confirmation.visible = true
