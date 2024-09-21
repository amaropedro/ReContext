extends Panel

@export var icon_svg: Texture
@export var card_name: String

@onready var icon_btn: TextureRect = $HomeBtn/Container/Icon
@onready var name_btn: RichTextLabel = $HomeBtn/Container/Name

func _ready() -> void:
	icon_btn.texture = icon_svg
	name_btn.text = "[center][color=47BDA8][font_size=30]"
	name_btn.text += card_name

func _on_home_btn_pressed() -> void:
	get_parent().get_parent().get_parent().get_parent().btn_dict[card_name]._on_pressed()
