extends Control

var gameName_dict = {
	"Complete": "[left][color=47BDA8][font_size=64] Completar Frases",
	"Flashcards": "[left][color=47BDA8][font_size=64] Revisar Palavras",
	"Translate": "[left][color=47BDA8][font_size=54] Memorizar Traduções"
}

@onready var page_name: RichTextLabel = $VBoxContainer/Control/PageName

func _ready() -> void:
	page_name.text = gameName_dict[SceneManager.SelectedGameName]
