extends Node

const RECONTEXT_KEY = preload("res://credentials.json").data.Key
const url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + RECONTEXT_KEY
var response_str: String
signal requestCompleted

@onready var http_request: HTTPRequest = $HTTPRequest
@onready var print_on_screen: RichTextLabel = $CanvasLayer/PrintOnScreen #Debug

func _on_http_request_request_completed(result, response_code, headers, body):
	print_on_screen.text += '\n' + str(response_code)
	if response_code == 200:
		response_str = parse_gemini_response(body)
		requestCompleted.emit()
		return
	
	print_on_screen.text += "Error:" + str(response_code)
	print_on_screen.text += '\n' + str(result)
	print_on_screen.text += '\n' + str(headers)
	response_str = "Error:" + str(response_code)
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

func generate_sentence(keyword: String, display_node: RichTextLabel):
	print_on_screen.text = '[center][color=blue]\n\n\nSending...' # Debug
	display_node.text = "sending..." # Debug
	
	generate_content(
		"Create a sentence that contains the word: '" 
		+ keyword + "' and then format it such that the word is blank. "
		+ "Don't respond with anything else besides the sentance."
	)
	await requestCompleted
	display_node.text = response_str
