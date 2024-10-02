extends Control

@export var cards: Dictionary = {}
@export var wrong: Texture2D
@export var check: Texture2D

@onready var sentence: RichTextLabel = $VBoxContainer/SentencePanel/Sentence
@onready var item_list: ItemList = $VBoxContainer/OptionsPanel/VBoxContainer/ItemList

@onready var confirm_btn: Button = $VBoxContainer/ConfirmContainer/Confirm/ConfirmBtn
@onready var confirm_container: HBoxContainer = $VBoxContainer/ConfirmContainer
@onready var options_container: HBoxContainer = $VBoxContainer/OptionsContainer
@onready var done_container: HBoxContainer = $VBoxContainer/DoneContainer
@onready var answer_container: HBoxContainer = $VBoxContainer/AnswerContainer
@onready var answer_btn: Button = $VBoxContainer/AnswerContainer/Confirm/AnswerBtn

var current_card_key = ""

var option_dict = {
	0: "a) ",
	1: "b) ",
	2: "c) ",
	3: "d) "
}

func _ready() -> void:
	cards = JsonManager.get_deck_cards(SceneManager.selectedDeck)
	
	if cards.is_empty():
		return
	
	current_card_key = cards.keys().pick_random()
	handle_card()

func _process(_delta: float) -> void:
	confirm_btn.disabled = !item_list.is_anything_selected()

func reset_answer():
	answer_container.visible = false
	answer_btn.text = "Mostrar Resposta"
	answer_btn.disabled = false

func handle_card():
	reset_answer()
	
	HttpManager.generate_sentence(current_card_key, sentence, "[left][font_size={32}][color=Black]")
	
	var all_cards = JsonManager.get_all_cards()
	var options = []
	
	all_cards.erase(current_card_key)
	item_list.clear()
	
	for i in range(3):
		if !all_cards.is_empty():
			options.append(all_cards.keys().pick_random())
			all_cards.erase(options[i])
	
	options.append(current_card_key)
	options.shuffle()
	
	for item in options:
		item_list.add_item(option_dict[item_list.item_count] + item)

func handle_next():
	cards.erase(current_card_key)
	if cards.is_empty():
		hanlde_done()
		return
	current_card_key = cards.keys().pick_random()
	handle_card()

func hanlde_done():
	pass

func _on_confirm_btn_pressed() -> void:
	var choice = item_list.get_item_text(item_list.get_selected_items()[0])
	choice = choice.erase(0, 3)
	for i in item_list.get_item_count():
		item_list.set_item_disabled(i, true)
	
	if choice == current_card_key:
		item_list.set_item_icon(item_list.get_selected_items()[0], check)
	else:
		item_list.set_item_icon(item_list.get_selected_items()[0], wrong)
		answer_container.visible = true
	
	confirm_container.visible = false
	options_container.visible = true

func _on_try_again_btn_pressed() -> void:
	handle_card()
	confirm_container.visible = true
	options_container.visible = false

func _on_next_btn_pressed() -> void:
	handle_next()
	confirm_container.visible = true
	options_container.visible = false

func _on_begin_again_btn_pressed() -> void:
	pass # Replace with function body.

func _on_done_btn_pressed() -> void:
	pass # Replace with function body.

func _on_answer_btn_pressed() -> void:
	if answer_btn.button_pressed:
		answer_btn.text = current_card_key + " - " + cards[current_card_key]
		answer_btn.disabled = true
		return
