extends Button

@onready var f_input: LineEdit = $"../../../Panel/VBoxContainer/FInput"
@onready var b_input: LineEdit = $"../../../Panel/VBoxContainer/BInput"

func _process(_delta: float) -> void:
	disabled = !(f_input.text != '' && b_input.text != '')
