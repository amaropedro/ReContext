extends LineEdit

@export var placeholder: String = "PlaceholderText"

func _ready() -> void:
	placeholder_text = placeholder

func _on_focus_entered() -> void:
	placeholder_text = ""

func _on_focus_exited() -> void:
	placeholder_text = placeholder
