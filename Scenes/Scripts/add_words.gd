extends Control

@onready var f_input: LineEdit = $VBoxContainer/Panel/VBoxContainer/FInput
@onready var b_input: LineEdit = $VBoxContainer/Panel/VBoxContainer/BInput
@onready var rich_text_label: RichTextLabel = $Synonym/Panel/VBoxContainer/RichTextLabel
@onready var add_syn: Button = $Synonym/Panel/VBoxContainer/VBoxContainer/Yes/AddSyn
@onready var dont_add_syn: Button = $Synonym/Panel/VBoxContainer/VBoxContainer/No/DontAddSyn
@onready var yes: Panel = $Synonym/Panel/VBoxContainer/VBoxContainer/Yes
@onready var no: Panel = $Synonym/Panel/VBoxContainer/VBoxContainer/No
@onready var save_word: Button = $VBoxContainer/HBoxContainer2/AddWordBtn/saveWord
@onready var synonym: CanvasLayer = $Synonym

const addToDeck = preload("res://Scenes/AddWordsToDeck.tscn")

func disable_btn():
	add_syn.disabled = true
	dont_add_syn.disabled = true
	yes.visible = false
	no.visible = false

func _on_add_next_step_btn_pressed() -> void:
	JsonManager.add_card(f_input.text, b_input.text)
	JsonManager.create_temp_cards({f_input.text: b_input.text})
	SceneManager.main.render(addToDeck, false)

func _on_save_word_pressed() -> void:
	JsonManager.create_temp_cards({f_input.text: b_input.text})
	save_word.disabled = true
	synonym.visible = true

func _on_add_syn_pressed() -> void:
	disable_btn()
	rich_text_label.text = "[center][color=black][font_size={36}]Gerando..."
	var res = await HttpManager.generate_synonyms(JsonManager.newWord.keys()[0])
	
	res.erase(JsonManager.newWord.keys()[0])
	JsonManager.save_temp_card()
	
	for word in res.keys():
		JsonManager.add_card(word, res[word])
	
	SceneManager.main.list._on_pressed()

func _on_dont_add_syn_pressed() -> void:
	disable_btn()
	JsonManager.save_temp_card()
	SceneManager.main.list._on_pressed()
