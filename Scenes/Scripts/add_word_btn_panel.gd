extends Panel

var btn

func _ready() -> void:
	btn = get_child(0)

func _process(_delta: float) -> void:
	modulate.a = 0.5 if btn.disabled else 1.0
	visible = btn.visible
