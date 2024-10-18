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

@onready var DoneText: RichTextLabel = $VBoxContainer/DonePanel/VBoxContainer/Front

var current_card_key = ""

var option_dict = {
	0: "a) ",
	1: "b) ",
	2: "c) ",
	3: "d) "
}

var rights = 0
var wrongs = 0
var retries = 0
var playtime: float = 0.0
var response: Dictionary

func _ready() -> void:
	rights = 0
	wrongs = 0
	retries = 0
	playtime = 0.0
	hide_done()
	cards = JsonManager.get_deck_cards(SceneManager.selectedDeck)
	
	if cards.is_empty():
		return
	
	current_card_key = cards.keys().pick_random()
	handle_card()

func _process(delta: float) -> void:
	confirm_btn.disabled = !item_list.is_anything_selected()
	
	playtime += delta

func reset_answer():
	answer_container.visible = false
	answer_btn.text = "Mostrar Resposta"
	answer_btn.disabled = false

func handle_card():
	reset_answer()
	item_list.clear()
	
	var format = "[left][font_size={32}][color=Black]"
	
	sentence.text = format + "Gerando..."
	response = await HttpManager.generate_sentence(current_card_key)
	sentence.text = format + response["English"]
	var all_cards = JsonManager.get_all_cards()
	var options = []
	
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
	
	var m = playtime/60
	var h = m/60
	var s = fmod(playtime, 60)
	m = fmod(m, 60)
	var timer = "\nTempo: %02d:%02d:%02d" % [h, m, s]
	
	var acc = (100*float(rights)/float(rights+wrongs))
	var encourage = "Parabéns!"
	
	if acc < 60:
		encourage = "Continue Tentando!"
	
	DoneText.text = "[color=Black][center][font_size={48}]\n" + encourage + "\nCategoria Concluída[/font_size][/center]"
	DoneText.text += "[left][font_size={32}]\nAcurácia: %.02f %%\nAcertos: %s\nErros: %s\nGeradas Novamente: %s" % [acc, rights, wrongs, retries]
	DoneText.text += timer

func _on_confirm_btn_pressed() -> void:
	var choice = item_list.get_item_text(item_list.get_selected_items()[0])
	choice = choice.erase(0, 3)
	for i in item_list.get_item_count():
		item_list.set_item_disabled(i, true)
	
	if choice == current_card_key:
		rights += 1
		item_list.set_item_icon(item_list.get_selected_items()[0], check)
	else:
		wrongs += 1
		item_list.set_item_icon(item_list.get_selected_items()[0], wrong)
		answer_container.visible = true
	
	confirm_container.visible = false
	options_container.visible = true

func _on_try_again_btn_pressed() -> void:
	retries += 1
	handle_card()
	confirm_container.visible = true
	options_container.visible = false

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
		sentence.text += "\n[color=47BDA8]" + response["Portuguese"]
		answer_btn.text = current_card_key + " - " + cards[current_card_key]
		answer_btn.disabled = true
		return
