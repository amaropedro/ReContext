extends Control

@onready var rich_text_label: RichTextLabel = $RichTextLabel

func _on_test_api_pressed() -> void:
	HttpManager.generate_sentence('car', rich_text_label)
