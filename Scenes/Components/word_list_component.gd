extends ScrollContainer

class_name WordList

@onready var v_box_container: VBoxContainer = $VBoxContainer

const item = preload("res://Scenes/Components/SelectableLine.tscn")
@export var selected: Dictionary = {}

func _ready() -> void:
	var cards = JsonManager.get_all_cards()
	
	for c in cards.keys():
		add_item(cards[c], c)

func is_anything_selected():
	return selected.is_empty()

func fill_deck():
	var deck = JsonManager.save_temp_deck()
	
	#As vezes acontecia um problema aqui que não encontrava o arquivo do deck. Não consegui replicar com consistencia
	for i in selected.keys():
		JsonManager.add_to_deck(i, selected[i], deck)

func remove_selected_cards_from_all():
	for c in selected.keys():
		JsonManager.remove_card_from_all(c)

func add_item(front: String, back: String):
	var line = item.instantiate()
	line.text_1 = front
	line.text_2 = back
	v_box_container.add_child(line)
	v_box_container.add_child(MarginContainer.new())

func _process(_delta: float) -> void:
	pass
