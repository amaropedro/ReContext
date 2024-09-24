extends ItemList

class_name DecKSelectBtn

func _ready() -> void:
	var decks = JsonManager.get_decks()
	
	if decks.size() == 1:
		return
	
	for d in decks.slice(1):
		add_item(d)

func add_to_selected_decks():
	var items = get_selected_items()
	for i in items:
		var deck_name = get_item_text(i)
		JsonManager.add_temp_card_to_deck(deck_name)
	
	JsonManager.save_temp_card()

func _process(_delta: float) -> void:
	pass
