extends HBoxContainer

@onready var deck_name: RichTextLabel = $DeckName
@onready var num_words: RichTextLabel = $NumWords

@onready var deck_list: DeckList = $"../.."

func _ready() -> void:
	deck_name.custom_minimum_size.x = deck_list.size.x * 0.8 - 56
	num_words.custom_minimum_size.x = deck_list.size.x * 0.2
