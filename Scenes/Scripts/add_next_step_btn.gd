extends Button

@onready var front_input: LineEdit = $"../../VBoxContainer/FInput"
@onready var back_input: LineEdit = $"../../VBoxContainer/BInput"

const addToDeck = preload("res://Scenes/AddWordsToDeck.tscn")

func _on_pressed() -> void:
	JsonManager.create_temp_cards({front_input.text: back_input.text})
	SceneManager.main.render(addToDeck, false)

func _process(_delta: float) -> void:
	disabled = !(front_input.text != '' && back_input.text != '')
