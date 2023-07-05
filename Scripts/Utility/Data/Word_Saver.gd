extends Resource
class_name Word_saver

const SAVE_GAME_PATH := DataManager.RESOURCE_FOLDER_PATH + "/word_save_data.tres"

@export
var words: Array[Word]

func save_data():
	ResourceSaver.save(self, SAVE_GAME_PATH)

static func load_data():
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH).duplicate(true)
	return null


func _find_word(word : String):
	for w in words:
		if w.word == word:
			return w;
	return null;
