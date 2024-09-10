extends RichTextLabel

func _ready() -> void:
	JsonManager.connect("word_added", update_txt)
	
	update_txt()

func update_txt():
	var all_words = JsonManager.get_all_words()
	var values = all_words.keys()
	text = ""
	for word in values:
		text += word + " - " + all_words[word] + "\n"
