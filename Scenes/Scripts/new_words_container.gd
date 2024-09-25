extends ScrollContainer

@onready var v_box_container: VBoxContainer = $VBoxContainer
const addWordLine = preload("res://Scenes/Components/AddWordLine.tscn")

func _ready() -> void:
	var all_words = JsonManager.newWord
	var values = all_words.keys()
	
	for word in values:
		var entry = addWordLine.instantiate()
		entry.text = "[color=black][font_size={24}]- " + all_words[word]
		v_box_container.add_child(entry)
