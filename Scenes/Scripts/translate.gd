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
@onready var done_panel: Panel = $VBoxContainer/DonePanel
@onready var sentence_panel: Panel = $VBoxContainer/SentencePanel
@onready var options_panel: Panel = $VBoxContainer/OptionsPanel
@onready var mode_select_container: HBoxContainer = $VBoxContainer/ModeSelectContainer

var current_card_key = ""
var current_card = ""

var option_dict = {
	0: "a) ",
	1: "b) ",
	2: "c) ",
	3: "d) "
}

var mode

func _ready() -> void:
	hide_done()
	mode_select()

func _process(_delta: float) -> void:
	confirm_btn.disabled = !item_list.is_anything_selected()

func mode_select():
	sentence.text = "[center][font_size={32}][color=Black]Escolha o modo"
	options_panel.visible = false
	confirm_container.visible = false
	mode_select_container.visible = true

func setup():
	options_panel.visible = true
	confirm_container.visible = true
	mode_select_container.visible = false
	
	cards = JsonManager.get_deck_cards(SceneManager.selectedDeck)
	
	if cards.is_empty():
		return
	
	current_card_key = cards.keys().pick_random()
	handle_card()

func reset_answer():
	answer_container.visible = false
	answer_btn.text = "Mostrar Resposta"
	answer_btn.disabled = false

func handle_card():
	reset_answer()
	item_list.clear()
	
	var all_cards = JsonManager.get_all_cards()
	var options = []
	
	
	if mode:
		sentence.text = "[center][font_size={32}][color=Black]" + current_card_key
		current_card = all_cards[current_card_key]
		all_cards.erase(current_card_key)
		
		for i in range(3):
			if !all_cards.is_empty():
				options.append(all_cards[all_cards.keys().pick_random()])
				all_cards.erase(options[i])
		
		options.append(current_card)
		options.shuffle()
		
		for item in options:
			item_list.add_item(option_dict[item_list.item_count] + item)
		return
	
	sentence.text = "[center][font_size={32}][color=Black]" + all_cards[current_card_key]
	all_cards.erase(current_card_key)
	
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

func hide_done():
	answer_container.visible = false
	confirm_container.visible = false
	options_container.visible = false
	confirm_container.visible = true
	done_container.visible = false
	done_panel.visible = false
	sentence_panel.visible = true
	options_panel.visible = true

func hanlde_done():
	answer_container.visible = false
	confirm_container.visible = false
	options_container.visible = false
	confirm_container.visible = false
	done_container.visible = true
	done_panel.visible = true
	sentence_panel.visible = false
	options_panel.visible = false

func _on_confirm_btn_pressed() -> void:
	var choice = item_list.get_item_text(item_list.get_selected_items()[0])
	var correct
	
	choice = choice.erase(0, 3)
	for i in item_list.get_item_count():
		item_list.set_item_disabled(i, true)
	
	if mode:
		correct = choice == current_card
	else:
		correct = choice == current_card_key
	
	if correct:
		item_list.set_item_icon(item_list.get_selected_items()[0], check)
	else:
		item_list.set_item_icon(item_list.get_selected_items()[0], wrong)
		answer_container.visible = true
	
	confirm_container.visible = false
	options_container.visible = true

func _on_next_btn_pressed() -> void:
	confirm_container.visible = true
	options_container.visible = false
	handle_next()

func _on_begin_again_btn_pressed() -> void:
	_ready()

func _on_done_btn_pressed() -> void:
	SceneManager.main.play._on_pressed()

func _on_answer_btn_pressed() -> void:
	if answer_btn.button_pressed:
		answer_btn.text = current_card_key + " - " + cards[current_card_key]
		answer_btn.disabled = true
		return

func _on_to_pt_pressed() -> void:
	mode = true
	setup()

func _on_to_eg_pressed() -> void:
	mode = false
	setup()
