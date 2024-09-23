extends GridContainer

class_name WordListLine

@export var front_text: String
@export var back_text: String

@onready var back: RichTextLabel = $Back
@onready var front: RichTextLabel = $Front

func _ready() -> void:
	back.text = "[center][color=black]" + back_text
	front.text = "[center][color=black]" + front_text
