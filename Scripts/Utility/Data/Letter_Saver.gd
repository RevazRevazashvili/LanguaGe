extends Resource
class_name Letter_saver

const SAVE_GAME_PATH := DataManager.RESOURCE_FOLDER_PATH + "/letter_save_data.tres"

@export
var letters: Array[Letter]


func save_data():
	ResourceSaver.save(self, SAVE_GAME_PATH)


static func load_data():
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH).duplicate(true)
	return null

func get_practiced():
	var count = 0.0
	
	for lett in letters:
		if lett.practice > 0:
			count += 1 
	
	return count/letters.size()

func _find_letter(letter : String):
	for letter_container in letters:
		if letter_container.letter == letter:
			return letter_container;
	return null;
