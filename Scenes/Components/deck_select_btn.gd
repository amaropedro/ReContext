extends ScrollContainer

class_name DeckList

@onready var v_box_container: VBoxContainer = $VBoxContainer

const item = preload("res://Scenes/Components/SelectableLine.tscn")
@export var selected: Array[String] = []
@export var listAllWordsOption: bool = false

func _ready() -> void:
	var decks = JsonManager.get_decks()
	
	if !listAllWordsOption:
		if decks.size() == 1:
			return
		decks.erase("AllWords")
	
	for d in decks:
		add_item(d)

func add_to_selected_decks():
	for i in selected:
		JsonManager.add_temp_cards_to_deck(i)
	
	JsonManager.save_temp_card()

func add_word_to_selected_decks(front: String, back: String):
	for i in selected:
		JsonManager.add_to_deck(front, back, i)
	
	JsonManager.add_card(front, back)

func del_selected_decks():
	for d in selected:
		JsonManager.delete_deck(d)

func is_anything_selected():
	return selected.is_empty()

func is_only_one_selected():
	return selected.size() == 1

func add_item(deckName: String):
	var line = item.instantiate()
	line.deck = true
	line.text_1 = "Todas as Palavras" if deckName == "AllWords" else deckName
	line.text_2 = str(JsonManager.get_deck_size(deckName))
	v_box_container.add_child(line)
	v_box_container.add_child(MarginContainer.new())

func filter_list(filter: String):
	for child in v_box_container.get_children():
		if child is SelectableLine:
			child.check_filter(filter)

func _process(_delta: float) -> void:
	pass
