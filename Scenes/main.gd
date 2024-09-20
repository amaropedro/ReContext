extends Control

@onready var rendered_scene: CanvasLayer = $RenderedScene
@onready var nav_bar: HBoxContainer = $BottomNavBar/NavBarContainer/NavBar
@onready var home: NavBtn = $BottomNavBar/NavBarContainer/NavBar/Home

func _ready() -> void:
	home._on_pressed()

func clear_selected_btn():
	for child in nav_bar.get_children():
		child.set_enabled(false)

func render(scene: PackedScene):
	if rendered_scene.get_child_count() > 0:
		rendered_scene.get_child(0).queue_free()
	
	var instance = scene.instantiate()
	rendered_scene.add_child(instance)
	clear_selected_btn()
	
