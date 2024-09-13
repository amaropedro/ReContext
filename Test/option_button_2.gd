extends OptionButton

@export var words :Dictionary
@onready var option_button: OptionButton = $"../OptionButton"

func update_options(new_words: Dictionary):
	clear()
	words = new_words
	
	var c = 0
	var values = words.keys()
	
	for word in values:
		var item_text = word + " - " + words[word] + "\n"
		add_item(item_text, c)
		c += 1
	
	select(0)

func add_to_deck(deckName):
	var front = words.keys()
	var back = words.values()
	JsonManager.add_to_deck(front[get_selected_id()], back[get_selected_id()], deckName)

func _on_button_4_pressed() -> void:
	var deck = option_button.get_item_text(option_button.get_selected_id())
	add_to_deck(deck)
