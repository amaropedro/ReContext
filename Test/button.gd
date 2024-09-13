extends Button

@onready var front: LineEdit = $"../Front"
@onready var back: LineEdit = $"../Back"

func _on_pressed() -> void:
	if front.text != '' && back.text != '':
		JsonManager.add_card(front.text, back.text)
		return
	
	print("Erro: insira nos campos frente e verso")
