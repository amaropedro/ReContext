extends Control

@onready var h_box_container: HBoxContainer = $BottomBar/VBoxContainer/HBoxContainer

func _ready() -> void:
	for child in h_box_container.get_children():
		child.set_enabled(false)
	
	h_box_container.get_child(0).set_enabled(true)
