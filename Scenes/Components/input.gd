extends LineEdit

@export var placeholder: String = "PlaceholderText"

@export var filter_target: ScrollContainer

func _ready() -> void:
	placeholder_text = placeholder

func _on_focus_entered() -> void:
	placeholder_text = ""

func _on_focus_exited() -> void:
	placeholder_text = placeholder

func _on_text_changed(new_text: String) -> void:
	if filter_target != null:
		filter_target.filter_list(new_text)
