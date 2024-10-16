extends Node

const deck_folder = "user://Decks/"
const path = deck_folder + "AllWords.json"

var newWord = {}
var newDeck = ""

signal word_added

func _ready() -> void:
	verify_save_dir()

func verify_save_dir():
	DirAccess.make_dir_absolute(deck_folder)
	if !FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.WRITE)
		var dict = {}
		file.store_string(JSON.stringify(dict, "\t"))
		file.close()

func create_temp_cards(cards: Dictionary):
	newWord = cards

func save_temp_card():
	var front = newWord.keys()[0]
	add_card(front, newWord[front])
	newWord = {}

func add_card(front: String, back: String) -> bool:
	var file = FileAccess.open(path, FileAccess.READ_WRITE)
	var all_words = JSON.parse_string(file.get_as_text())
	
	if all_words.get(front) == null:
		all_words.get_or_add(front.capitalize(), back.capitalize())
		
		file.store_string(JSON.stringify(all_words, "\t"))
		file.close()
		word_added.emit()
		return true
	
	file.close()
	word_added.emit()
	SceneManager.alert("Palavra já adicionada")
	return false

func get_all_cards() -> Dictionary:
	var file = FileAccess.open(path, FileAccess.READ)
	var all_words = JSON.parse_string(file.get_as_text())
	
	file.close()
	return all_words

func remove_card_from_all(card_key: String):
	var decks = get_decks()
	for d in decks:
		remove_card_from_deck(card_key, d)

func remove_card_from_deck(front: String, deckName: String):
	var deck_path = deck_folder + deckName + ".json"
	var file = FileAccess.open(deck_path, FileAccess.READ)
	var words = JSON.parse_string(file.get_as_text())
	file.close()
	file = FileAccess.open(deck_path, FileAccess.WRITE)
	
	words.erase(front)
	file.store_string(JSON.stringify(words, "\t"))
	file.close()

func create_temp_deck(deckName: String):
	newDeck = deckName

func save_temp_deck() -> String:
	var d = newDeck
	new_deck(newDeck)
	newDeck = ""
	return d.capitalize() 

func new_deck(DeckName: String) -> bool:
	var new_deck_path = deck_folder + DeckName.capitalize() + ".json"
	if !FileAccess.file_exists(new_deck_path):
		var file = FileAccess.open(new_deck_path, FileAccess.WRITE)
		var dict = {}
		file.store_string(JSON.stringify(dict, "\t"))
		file.close()
		return true
	
	SceneManager.alert("Erro: já existe um deck com esse nome", "Red")
	return false

func delete_deck(DeckName: String) -> bool:
	var deck_path = deck_folder + DeckName + ".json"
	
	if DeckName == "AllWords":
		var file = FileAccess.open(deck_path, FileAccess.WRITE)
		var dict = {}
		file.store_string(JSON.stringify(dict, "\t"))
		file.close()
		return true
	
	if FileAccess.file_exists(deck_path):
		DirAccess.remove_absolute(deck_path)
		return true
	
	#Nunca deve conseguir chegar aqui
	return false

func get_decks() -> Array:
	var decks = []
	for file in DirAccess.get_files_at(deck_folder):
		decks.append(file.substr(0, file.length()-5))
	
	return decks

func get_deck_cards(deckName: String) -> Dictionary:
	var deck_path = deck_folder + deckName + ".json"
	var file = FileAccess.open(deck_path, FileAccess.READ)
	var all_words = JSON.parse_string(file.get_as_text())
	
	file.close()
	return all_words

func add_to_deck(front: String, back: String, deckName: String):
	var deck_path = deck_folder + deckName + ".json"
	var file = FileAccess.open(deck_path, FileAccess.READ_WRITE)
	var words = JSON.parse_string(file.get_as_text())
	
	if words.get(front) == null:
		words.get_or_add(front.capitalize(), back.capitalize())
		
		file.store_string(JSON.stringify(words, "\t"))
		file.close()
		return true
	
	file.close()
	SceneManager.alert("Palavra já está nesse deck")
	return false

func add_temp_cards_to_deck(deckName: String):
	for front in newWord.keys():
		add_to_deck(front, newWord[front], deckName)

func get_deck_size(deckName: String) -> int:
	var deck_path = deck_folder + deckName + ".json"
	var file = FileAccess.open(deck_path, FileAccess.READ_WRITE)
	var words = JSON.parse_string(file.get_as_text()).keys()
	return words.size()
