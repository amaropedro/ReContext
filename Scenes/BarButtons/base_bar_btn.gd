extends Button

@export var icon_file: Texture

@onready var current: ColorRect = $Current
@onready var icon_svg: TextureRect = $IconSVG

func _ready() -> void:
	icon_svg.texture = icon_file

func set_enabled(value: bool):
	current.visible = value
	
	if value:
		icon_svg.modulate = Color(Meta.COLORS["Green"], 1)
		return
	
	icon_svg.modulate = Color(Meta.COLORS["NonFocus"], 1)
