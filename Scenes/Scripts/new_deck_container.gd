extends ScrollContainer

@onready var v_box_container: VBoxContainer = $VBoxContainer
const addWordLine = preload("res://Scenes/Components/AddWordLine.tscn")

func _ready() -> void:
	var word = JsonManager.newDeck
	
	var entry = addWordLine.instantiate()
	entry.text = "[color=black][font_size={24}]- " + word
	v_box_container.add_child(entry)
