extends Control

@onready
var last_page = $LessonCompleted 					# ტესტის დამთავრების გვერდი რომელიც ყველა ტესტის გავლის შემდეგ გამოჩნდება

# ტესტების ტიპები რომლებიც ჩაიტვირთება მოთხოვნებისამებრ
@onready
var sound_lesson : SoundLesson = $LessonsSpace/SoundLessons
@onready
var writing_lesson : WritingLesson = $LessonsSpace/WritingLesson
@onready
var quiz_lesson : QuizLesson = $LessonsSpace/QuizLesson
@onready
var draw_lesson = $LessonsSpace/WriteLessons


@onready
var continue_button = $Continue


var current_lesson : Lesson			# მიმდინარე ჩატვირთული გაკვეთილი

var current_lesson_index = 0		# მიმდინარე ტესტის ინდექსი lessons - მასივში

var current_score = 0				# მიმდინარე ქულა (სწორად გაცემული კითხვების რაოდენობა)

var lesson_compleated_page = false

func _on_continue_pressed() -> void:
	if current_lesson.is_selected_correct():
		current_score += 1
		$CorrectAnswerAudio.play()
	else:
		$IncorrectAnswerAudio.play()
	
	continue_button.disabled = true;
	
	if(_has_next_lesson()):
		_load_next_lesson()
	elif(lesson_compleated_page):
		SceneController.back_to_previous()
	else:
		lesson_compleated_page = true
		last_page.set_score(current_score)
		_load_last_page()


func _ready() -> void:
	continue_button.disabled = true
	current_score = 0

	_load_next_lesson()


func _answer_selected():
	continue_button.disabled = false

func _answer_deselected():
	continue_button.disabled = true

func _move_continue_up():
	pass

func _move_continue_down():
	pass

func _has_next_lesson():
	return Watchman.lesson_controller.has_next_lesson()

func _load_next_lesson():
	var next_lesson_data = Watchman.lesson_controller.get_next_lesson()
	
	match next_lesson_data[0]:
		Watchman.TEST_TYPE.quiz:
			_load_quiz_lesson(next_lesson_data[1], next_lesson_data[2], next_lesson_data[3][0], next_lesson_data[3][1], next_lesson_data[3][2], next_lesson_data[3][3])
		Watchman.TEST_TYPE.sound:
			_load_sound_lesson(next_lesson_data[1], next_lesson_data[2], next_lesson_data[3][0], next_lesson_data[3][1], next_lesson_data[3][2], next_lesson_data[3][3])
		Watchman.TEST_TYPE.text:
			_load_writing_lesson(next_lesson_data[1], next_lesson_data[2])


# this functions need to be rewritten
func _load_last_page():
	last_page.get_node("LessonComplitedAudio").play()
	current_lesson.deinitialize()
	continue_button.disabled = false
	last_page.visible = true
	
	Watchman.lesson_controller.save_data()




# გადაეცემა კითხვა სწორი პასუხი და სავარაუდო პასუხები
func _load_sound_lesson(question, right_answer : int, answer1, answer2, answer3, answer4):
	sound_lesson.load_info(question, right_answer, answer1, answer2, answer3, answer4)
	
	_change_current_lesson_to(sound_lesson)


# გადაეცემა კითხვა და სწორი პასუხი
func _load_writing_lesson(question : String, right_answer : String):
	writing_lesson.load_info(question, right_answer)
	
	_change_current_lesson_to(writing_lesson)


# გადაეცემა კითხვა, სწორი პასუხის ნომერი, სავარაუდო პასუხები
func _load_quiz_lesson(question : String, right_answer : int, answer1 : String, answer2 : String, answer3 : String, answer4 : String):
	# load info
	quiz_lesson.load_info(question, right_answer, answer1, answer2, answer3, answer4)
	
	_change_current_lesson_to(quiz_lesson)


# გადაეცემა კითხვა და სწორი პასუხის ინდექსი? მაგალითად თუ "ა" გადაეცა ჩატვირთავს ა.tsnc - ის?
func _load_draw_lesson(question : String, right_answer : String):
	# load info
	
	if(current_lesson != null):
		current_lesson.deinitialize()
	
	current_lesson = draw_lesson
	
	current_lesson.initialize()



func _change_current_lesson_to(lesson : Lesson):
	if(current_lesson != null):
		current_lesson.disconnect("selected", _answer_selected)
		current_lesson.disconnect("deselected", _answer_deselected)
		# current_lesson.disconnect("move_continue_up", _answer_deselected)
		# current_lesson.disconnect("move_continue_down", _answer_deselected)
		current_lesson.deinitialize()
	
	current_lesson = lesson
	current_lesson.connect("selected", _answer_selected)
	current_lesson.connect("deselected", _answer_deselected)
	# current_lesson.connect("move_continue_up", _answer_deselected)
	# current_lesson.connect("move_continue_down", _answer_deselected)
	
	current_lesson.initialize()

