extends HBoxContainer

class_name SelectableLine

@export var deck: bool

@onready var deck_list: DeckList = $"../.."
@onready var col_1: VBoxContainer = $Col1
@onready var col_2: VBoxContainer = $Col2
@onready var col_1_text: RichTextLabel = $Col1/Col1Text
@onready var col_2_text: RichTextLabel = $Col2/Col2Text
@onready var check_box: CheckBox = $VBoxContainer/CheckBox

@export var text_1: String = "1"
@export var text_2: String = "2"

var bbCodeAlign = "[center]"
var bbCodeColor = "[color=8D8D8D]"

func _ready() -> void:
	if deck:
		col_1.custom_minimum_size.x = deck_list.size.x * 0.8 - check_box.size.x
		col_1.size_flags_horizontal = 2
		col_2.custom_minimum_size.x = deck_list.size.x * 0.2
		col_2.size_flags_horizontal = 2
	
	updade_text()

func updade_text():
	# add crop de texto com '...'
	if deck:
		col_1_text.text = "[left]" + bbCodeColor + text_1
	else:
		col_1_text.text = bbCodeAlign + bbCodeColor + text_1
	
	col_2_text.text =bbCodeAlign + bbCodeColor + text_2

func _on_check_box_pressed() -> void:
	if check_box.button_pressed:
		bbCodeColor = "[color=47BDA8]"
		updade_text()
		deck_list.selected.append(text_1)
		return
	
	bbCodeColor = "[color=8D8D8D]"
	updade_text()
	deck_list.selected.erase(text_1)
