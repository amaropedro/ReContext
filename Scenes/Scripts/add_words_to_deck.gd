extends Control

@onready var deck_list: DeckList = $VBoxContainer/Panel/VBoxContainer/DeckList

@onready var add_syn: Button = $Synonym/Panel/VBoxContainer/VBoxContainer/Yes/AddSyn
@onready var dont_add_syn: Button = $Synonym/Panel/VBoxContainer/VBoxContainer/No/DontAddSyn
@onready var yes: Panel = $Synonym/Panel/VBoxContainer/VBoxContainer/Yes
@onready var no: Panel = $Synonym/Panel/VBoxContainer/VBoxContainer/No
@onready var rich_text_label: RichTextLabel = $Synonym/Panel/VBoxContainer/RichTextLabel

@onready var add_to_deck_btn: Button = $VBoxContainer/HBoxContainer2/AddWordBtn/AddToDeckBtn
@onready var synonym: CanvasLayer = $Synonym

func _process(_delta: float) -> void:
	add_to_deck_btn.disabled = deck_list.is_anything_selected()

func disable_btn():
	add_syn.disabled = true
	dont_add_syn.disabled = true
	yes.visible = false
	no.visible = false

func _on_dont_add_syn_pressed() -> void:
	deck_list.add_to_selected_decks()
	SceneManager.main.list._on_pressed()
	disable_btn()

func _on_add_syn_pressed() -> void:
	disable_btn()
	rich_text_label.text = "[center][color=black][font_size={36}]Gerando..."
	var res = await HttpManager.generate_synonyms(JsonManager.newWord.keys()[0])
	
	res.erase(JsonManager.newWord.keys()[0])
	deck_list.add_to_selected_decks()
	
	for word in res.keys():
		deck_list.add_word_to_selected_decks(word, res[word])
	
	SceneManager.main.list._on_pressed()

func _on_add_to_deck_btn_pressed() -> void:
	add_to_deck_btn.disabled = true
	synonym.visible = true
