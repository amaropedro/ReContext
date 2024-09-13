extends Button

@onready var option_button: OptionButton = $"../OptionButton"

func _on_pressed() -> void:
	var deck = option_button.get_item_text(option_button.get_selected_id())
	
	return JsonManager.delete_deck(deck)
