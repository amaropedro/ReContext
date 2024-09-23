extends Panel

@onready var v_box_container: VBoxContainer = $ScrollContainer/VBoxContainer

const wordListLine = preload("res://Scenes/Components/WordListLine.tscn")

func _ready() -> void:
	var all_words = JsonManager.get_all_cards()
	var values = all_words.keys()
	
	for word in values:
		var entry = wordListLine.instantiate()
		entry.front_text = word
		entry.back_text = all_words[word]
		v_box_container.add_child(entry)
	
