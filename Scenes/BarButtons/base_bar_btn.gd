extends Button

class_name NavBtn

@export var icon_file: Texture
@export var page: PackedScene = null

@onready var current: ColorRect = $Current
@onready var icon_svg: TextureRect = $IconSVG

func _ready() -> void:
	icon_svg.texture = icon_file
	set_enabled(false)

func set_enabled(value: bool):
	current.visible = value
	
	if value:
		icon_svg.modulate = Color(Meta.COLORS["Green"], 1)
		return
	
	icon_svg.modulate = Color(Meta.COLORS["NonFocus"], 1)

func _on_pressed() -> void:
	if page != null:
		Main.render(page, self)
		set_enabled(true)
