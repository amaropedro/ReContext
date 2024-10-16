extends Control

const path = "user://customKey.json"

@onready var input: LineEdit = $VBoxContainer/Panel/Input
@onready var check_box: CheckBox = $VBoxContainer/Panel/CheckBox

var settings = {
	"Enabled": false,
	"CustomKey": ""
}

func _ready() -> void:
	verify_save_dir()
	
	if settings["CustomKey"] != "": 
		input.placeholder_text = settings["CustomKey"]
	
	check_box.button_pressed = settings["Enabled"] == true

func verify_save_dir():
	var file
	
	if !FileAccess.file_exists(path):
		file = FileAccess.open(path, FileAccess.WRITE)
		
		file.store_string(JSON.stringify(settings, "\t"))
		file.close()
		return
	
	file = FileAccess.open(path, FileAccess.READ)
	 
	settings = JSON.parse_string(file.get_as_text())
	file.close()

func _on_input_text_submitted(new_text: String) -> void:
	var file = FileAccess.open(path, FileAccess.WRITE)
	
	settings["CustomKey"] = new_text
	file.store_string(JSON.stringify(settings, "\t"))
	file.close()

func _on_check_box_pressed() -> void:
	var file = FileAccess.open(path, FileAccess.WRITE)
	
	settings["Enabled"] = check_box.button_pressed
	file.store_string(JSON.stringify(settings, "\t"))
	file.close()
	HttpManager._ready()
