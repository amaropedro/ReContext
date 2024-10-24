extends Control

@onready var rich_text_label: RichTextLabel = $RichTextLabel

func _on_test_api_pressed() -> void:
	pass
	# var all = JsonManager.get_all_cards().values()
	# var word = all.pick_random()
	# HttpManager.generate_sentence(word, rich_text_label)
