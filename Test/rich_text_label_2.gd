extends RichTextLabel

@onready var option_button_2: OptionButton = $"../OptionButton2"

func _ready() -> void:
	JsonManager.connect("word_added", update_txt)
	
	update_txt()

func update_txt():
	var all_words = JsonManager.get_all_cards()
	var values = all_words.keys()
	option_button_2.update_options(all_words)
	text = ""
	for word in values:
		text += word + " - " + all_words[word] + "\n"
