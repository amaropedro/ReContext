extends Button

@onready var front_input: LineEdit = $"../../VBoxContainer/FrontInput"
@onready var back_input: LineEdit = $"../../VBoxContainer/BackInput"

func _on_pressed() -> void:
	JsonManager.add_card(front_input.text, back_input.text)

func _process(_delta: float) -> void:
	disabled = !(front_input.text != '' && back_input.text != '')
