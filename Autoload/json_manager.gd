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

func create_temp_card(front: String, back: String):
	newWord.get_or_add(front.capitalize(), back.capitalize())

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
	return false

func get_all_cards() -> Dictionary:
	var file = FileAccess.open(path, FileAccess.READ_WRITE)
	var all_words = JSON.parse_string(file.get_as_text())
	
	file.close()
	return all_words

# Para iterar o deck seria algo do tipo
# Posso também pegar aleatoriamente uma palavra e ir removendo ela do array
func iterate_deck(deck):
	if deck == 'all':
		var all_words = get_all_cards()
		var values = all_words.keys()
		for word in values:
			print(word, " ", all_words[word])

func create_temp_deck(deckName: String):
	newDeck = deckName

func save_temp_deck():
	new_deck(newDeck)
	newDeck = ""

func new_deck(DeckName: String) -> bool:
	var new_deck_path = deck_folder + DeckName.capitalize() + ".json"
	if !FileAccess.file_exists(new_deck_path):
		var file = FileAccess.open(new_deck_path, FileAccess.WRITE)
		var dict = {}
		file.store_string(JSON.stringify(dict, "\t"))
		file.close()
		return true
	
	print("Erro: já existe um deck com esse nome")
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
	print('Palavra já está nesse deck')
	return false

func add_temp_card_to_deck(deckName):
	var front = newWord.keys()[0]
	add_to_deck(front, newWord[front], deckName)

func fill_deck():
	pass
