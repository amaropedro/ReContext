extends Node

const path = "res://Decks/AllWords.json"

signal word_added

func add_word(front: String, back: String) -> bool:
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

func get_all_words() -> Dictionary:
	var file = FileAccess.open(path, FileAccess.READ_WRITE)
	var all_words = JSON.parse_string(file.get_as_text())
	
	file.close()
	return all_words

# Para iterar o deck seria algo do tipo
# Posso também pegar aleatoriamente uma palavra e ir removendo ela do array
func iterate_deck(deck):
	if deck == 'all':
		var all_words = get_all_words()
		var values = all_words.keys()
		for word in values:
			print(word, " ", all_words[word])
