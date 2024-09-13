extends OptionButton

func _ready() -> void:
	var d = JsonManager.get_decks()
	var c = 0
	for f in d:
		add_item(f, c)
		c += 1
	
	select(0)
	
