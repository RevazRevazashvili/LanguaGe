extends Resource
class_name Data_saver

const SAVE_GAME_PATH := DataManager.RESOURCE_FOLDER_PATH + "/save_data.tres"

@export
var letter_data: Array[Letter]

func save_data():
	ResourceSaver.save(self, SAVE_GAME_PATH)

static func load_data():
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH).duplicate(true)
	return null


func _find_letter(letter : String):
	for letter_container in letter_data:
		if letter_container.letter == letter:
			return letter_container;
	return null;

func _change_letter_practice(letter : String, new_val : int):
	var letr : Letter = _find_letter(letter)
	if letr == null:
		return false
	
	letr.practice = new_val
	return true

func increment_letter_practice(letter : String):
	var letr : Letter = _find_letter(letter)
	if letr == null:
		return false
	
	letr.practice += 1
	return true

