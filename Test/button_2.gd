extends Button

@onready var new_deck: LineEdit = $"../NewDeck"

func _on_pressed() -> void:
	if new_deck.text != '':
		return JsonManager.new_deck(new_deck.text)
	
	print("Erro: insira nos campos frente e verso")
