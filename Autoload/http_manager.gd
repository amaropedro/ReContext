extends Node

const RECONTEXT_KEY = preload("res://credentials.json").data.Key
const BASE_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key="
var url = ""
var response_str: String
signal requestCompleted

@onready var http_request: HTTPRequest = $HTTPRequest

func _ready() -> void:
	var path = "user://customKey.json"
	
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		 
		var settings = JSON.parse_string(file.get_as_text())
		file.close()
		
		if settings["Enabled"] == true:
			url = BASE_URL + settings["CustomKey"]
			return
	
	url = BASE_URL + RECONTEXT_KEY

func _on_http_request_request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		response_str = parse_gemini_response(body)
		requestCompleted.emit()
		return
	
	SceneManager.alert("Erro " + str(response_code) + " na api. Tente novamente mais tarde.", "Red")
	#"Error: response: " + str(response_code) + " result: " + str(result) + " headers: " + str(headers)
	response_str = ""
	requestCompleted.emit()

func generate_content(prompt):
	var headers = ["Content-Type: application/json"]
	
	var request_data = {
		"contents": [{
			"parts":[{
				"text": prompt
			}]
		}]
	}
	
	http_request.request(url, headers, HTTPClient.METHOD_POST, JSON.stringify(request_data))

func parse_gemini_response(body):
	var response_string = JSON.parse_string(body.get_string_from_utf8())
	
	var content = response_string['candidates'][0]['content']['parts'][0]['text']
	return content

func generate_sentence(keyword: String):
	generate_content(
		"Create a sentence that contains the word: '" 
		+ keyword + "' and then format it such that the word is blank (underlines). "
		+ "Also translate it to Portuguese. Format the answer in a JSON as such {English: ..., Portuguese: ...}" 
		+ "Don't respond with anything else besides the JSON."
	)
	await requestCompleted
	return JSON.parse_string(response_str)

func generate_synonyms(keyword: String) -> Dictionary:
	generate_content(
		"Generate up to 5 synonyms to the word '"
		+ keyword +
		"' , if they exist. Also, translate them to Portuguese. Format the answer in JSON, like so {\"X1\": \"Y1\", \"X2\": \"Y2\", ...}. Where X is the English word and Y is the Portuguese word. Always respond with only the JSON string."
	)
	await  requestCompleted
	
	var dict = JSON.parse_string(response_str)
	
	if dict == null:
		SceneManager.alert("Erro gerando sinônimos. Verifique se a palavra em inglês foi escrita corretamente.")
		return {}
	
	return JSON.parse_string(response_str)
