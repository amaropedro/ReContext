extends Control

@onready var deck_name: RichTextLabel = $VBoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/DeckName
@onready var word_list: Panel = $VBoxContainer/WordList
@onready var rmv_from_deck_btn: Button = $VBoxContainer/VBoxContainer/RmvWordBtn/rmvFromDeckBtn

const deckWordList = preload("res://Scenes/Components/DeckWordListComponent.tscn")

func _ready() -> void:
	deck_name.text = "[left][color=47BDA8][font_size=32] " + SceneManager.deckToManage
