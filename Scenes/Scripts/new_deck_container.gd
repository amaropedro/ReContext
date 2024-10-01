extends ScrollContainer

@onready var v_box_container: VBoxContainer = $VBoxContainer
const addWordLine = preload("res://Scenes/Components/AddWordLine.tscn")

@export var isSelected: bool = false

func _ready() -> void:
	var word = ""
	if isSelected:
		word = SceneManager.deckToManage
	else:
		word = JsonManager.newDeck
	
	var entry = addWordLine.instantiate()
	entry.text = "[color=47BDA8][font_size={32}] " + word
	v_box_container.add_child(entry)
