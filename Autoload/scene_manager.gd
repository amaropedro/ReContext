extends Node

var main
var sceneHistory = []
var deckToManage: String = ""
var selectedGame: PackedScene
var SelectedGameName: String = ""
var selectedDeck: String = ""

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var panel: Panel = $CanvasLayer/Panel
@onready var rich_text_label: RichTextLabel = $CanvasLayer/Panel/VBoxContainer/RichTextLabel
@onready var timer: Timer = $CanvasLayer/Timer
@onready var progress_bar: ProgressBar = $CanvasLayer/Panel/ProgressBar

func _process(_delta: float) -> void:
	progress_bar.value = timer.time_left

func alert(msg: String, color: String = "Yellow" ) -> void:
	canvas_layer.visible = true
	var new_theme = StyleBoxFlat.new()
	new_theme.bg_color = Color(Meta.COLORS[color])
	new_theme.shadow_offset = Vector2(0, 2)
	new_theme.shadow_color = Color(0, 0, 0, 0.25)
	new_theme.shadow_size = 1
	panel.add_theme_stylebox_override("panel", new_theme)
	
	if color == "Yellow":
		rich_text_label.text = "[color=black]"
	else:
		rich_text_label.text = ""
	
	rich_text_label.text += "[font_size={32}]" + msg
	timer.start(4)
	progress_bar.max_value = 4

func _on_timer_timeout() -> void:
	timer.stop()
	canvas_layer.visible = false
