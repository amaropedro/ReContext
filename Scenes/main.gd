extends Control

@onready var rendered_scene: CanvasLayer = $RenderedScene
@onready var nav_bar: HBoxContainer = $BottomNavBar/NavBarContainer/NavBar

@onready var home: NavBtn = $BottomNavBar/NavBarContainer/NavBar/Home
@onready var play: NavBtn = $BottomNavBar/NavBarContainer/NavBar/Play
@onready var list: NavBtn = $BottomNavBar/NavBarContainer/NavBar/List
@onready var decks: NavBtn = $BottomNavBar/NavBarContainer/NavBar/Decks
@onready var add: NavBtn = $BottomNavBar/NavBarContainer/NavBar/Add
@onready var about_btn: Node = $AboutBtn
@onready var guide_btn: Node = $GuideBtn

@onready var btn_dict = {
	"JOGAR": play,
	"CATEGORIAS": decks,
	"LISTA DE PALAVRAS": list,
	"ADICIONAR PALAVRAS": add,
	"COMO USAR": home,
	"SOBRE": about_btn
}

func _ready() -> void:
	home._on_pressed()
	SceneManager.main = self

func clear_selected_btn():
	for child in nav_bar.get_children():
		child.set_enabled(false)

func render(scene: PackedScene, clear_btn: bool = true):
	if rendered_scene.get_child_count() > 0:
		rendered_scene.get_child(0).queue_free()
	
	var instance = scene.instantiate()
	rendered_scene.add_child(instance)
	if clear_btn:
		clear_selected_btn()

func load_render(scenePath: String):
	var scene = load(scenePath)
	
	if rendered_scene.get_child_count() > 0:
		rendered_scene.get_child(0).queue_free()
	
	var instance = scene.instantiate()
	rendered_scene.add_child(instance)
