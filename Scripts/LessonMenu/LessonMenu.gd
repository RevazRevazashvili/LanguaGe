extends Control


@onready
var swipe_menu = $SwipeMenu

@onready
var progress : TextureProgressBar = $ProgressBar


func _on_button_pressed() -> void:
	# according to this launch
	Watchman.load_lesson_interface_by_index(swipe_menu.card_current_index)


func _on_swipe_menu_card_changed(index):
	match Watchman.lessons_enums[index]:
		Watchman.LESSON_TYPE.lett: _load_letters_lessons_progress()
		Watchman.LESSON_TYPE.s_wrd: _load_simple_words_lessons_progress()
		Watchman.LESSON_TYPE.mixd: _load_practice_lessons_progress()


func _load_letters_lessons_progress():
	var progress_value = Letter_saver.load_data().get_practiced()
	
	progress.visible = true
	progress.value = 100*progress_value

func _load_simple_words_lessons_progress():
	var progress_value = Word_saver.load_data().get_practiced()
	
	progress.visible = true
	progress.value = 100*progress_value

func _load_practice_lessons_progress():
	progress.visible = false
	
	return	
	# depricated
	var letter_progress = Letter_saver.load_data().get_practiced()
	var word_progress = Word_saver.load_data().get_practiced()
	progress.value = 100*(letter_progress + word_progress)/2



