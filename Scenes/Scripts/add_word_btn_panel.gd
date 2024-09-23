extends Panel

@onready var add_btn: Button = $AddBtn

func _process(_delta: float) -> void:
	modulate.a = 0.5 if add_btn.disabled else 1.0
