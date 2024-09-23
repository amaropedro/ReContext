extends Button

@onready var front_input: LineEdit = $"../../VBoxContainer/FrontInput"
@onready var back_input: LineEdit = $"../../VBoxContainer/BackInput"

func _on_pressed() -> void:
	if front_input.text != '' && back_input.text != '':
		JsonManager.add_card(front_input.text, back_input.text)
		return
	
	print("Erro: insira nos campos frente e verso")
