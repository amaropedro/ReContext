extends Control

@export var cards: Dictionary = {}

@onready var front: RichTextLabel = $VBoxContainer/FrontPanel/Front
@onready var back: RichTextLabel = $VBoxContainer/BackPanel/Back
@onready var front_panel: Panel = $VBoxContainer/FrontPanel
@onready var back_panel: Panel = $VBoxContainer/BackPanel
@onready var done_panel: Panel = $VBoxContainer/DonePanel
@onready var done_container: HBoxContainer = $VBoxContainer/DoneContainer

@onready var options_container: HBoxContainer = $VBoxContainer/OptionsContainer
@onready var reveal_container: HBoxContainer = $VBoxContainer/RevealContainer

var current_card_key = ""

func _ready() -> void:
	hide_done()
	cards = JsonManager.get_deck_cards(SceneManager.selectedDeck)
	
	current_card_key = cards.keys().pick_random()
	handle_card()

func handle_card():
	front.text = "[center][font_size={48}][color=Black]" + current_card_key
	back.text = "[center][font_size={48}][color=Black]" + cards[current_card_key]

func handle_next():
	hide_back()
	cards.erase(current_card_key)
	if cards.is_empty():
		hanlde_done()
		return
	current_card_key = cards.keys().pick_random()
	handle_card()

func reveal_back():
	back.visible = true
	reveal_container.visible = false
	options_container.visible = true

func hide_back():
	back.visible = false
	reveal_container.visible = true
	options_container.visible = false

func hide_done():
	front_panel.visible = true
	back_panel.visible = true
	reveal_container.visible = true
	done_container.visible = false
	options_container.visible = false
	done_panel.visible = false

func hanlde_done():
	front_panel.visible = false
	back_panel.visible = false
	reveal_container.visible = false
	options_container.visible = false
	done_panel.visible = true
	done_container.visible = true

func _on_reveal_btn_pressed() -> void:
	reveal_back()

func _on_try_again_btn_pressed() -> void:
	hide_back()

func _on_next_btn_pressed() -> void:
	handle_next()

func _on_done_btn_pressed() -> void:
	SceneManager.main.play._on_pressed()

func _on_begin_again_btn_pressed() -> void:
	_ready()
