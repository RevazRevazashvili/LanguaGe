extends Control


@export # this wont be needed remove it
var last_page: Node					# ტესტის დამთავრების გვერდი რომელიც ყველა ტესტის გავლის შემდეგ გამოჩნდება


# ტესტების ტიპები რომლებიც ჩაიტვირთება მოთხოვნებისამებრ
@onready
var sound_lesson = $LessonsSpace/SoundLessons
@onready
var text_lesson = $LessonsSpace/TextLessons
@onready
var quizz_lesson = $LessonsSpace/QuizzLessons
@onready
var write_lesson = $LessonsSpace/WriteLessons


@onready
var continue_button = $Continue



var current_lesson : Lesson			# მიმდინარე ჩატვირთული გაკვეთილი

var current_lesson_index = 0		# მიმდინარე ტესტის ინდექსი lessons - მასივში

var current_score = 0				# მიმდინარე ქულა (სწორად გაცემული კითხვების რაოდენობა)


func _on_continue_pressed() -> void:
	if current_lesson.is_selected_correct():
		current_score += 1
	
	continue_button.disabled = true;
	
	if(_has_next_lesson()):
		_load_next_lesson()
	else:
		_load_last_page()


func _ready() -> void:
	continue_button.disabled = true
	current_score = 0
	
	sound_lesson.visible = false
	#text_lesson.visible = false
	#quizz_lesson.visible = false
	#write_lesson.visible = false
	
	# this is a test
	_load_next_lesson()
	# load lessons from somewhere
	
	# define current lesson
	
	current_lesson.connect("selected", _answer_selected)


func _answer_selected():
	continue_button.disabled = false;

func _has_next_lesson():
	return Watchman.lesson_controller.has_next_lesson()

func _load_next_lesson():
	var next_lesson_data = Watchman.lesson_controller.get_next_lesson()
	
	match next_lesson_data[0]:
		Watchman.TEST_TYPE.quiz:
			_load_sound_lesson(next_lesson_data[1], next_lesson_data[2], next_lesson_data[3][0], next_lesson_data[3][1], next_lesson_data[3][2], next_lesson_data[3][3])
			#_load_quiz_lesson(next_lesson_data[1], next_lesson_data[2], next_lesson_data[3][0], next_lesson_data[3][1], next_lesson_data[3][2], next_lesson_data[3][3])
		Watchman.TEST_TYPE.sound:
			_load_sound_lesson(next_lesson_data[1], next_lesson_data[2], next_lesson_data[3][0], next_lesson_data[3][1], next_lesson_data[3][2], next_lesson_data[3][3])
		Watchman.TEST_TYPE.text:
			_load_sound_lesson(next_lesson_data[1], next_lesson_data[2], next_lesson_data[3][0], next_lesson_data[3][1], next_lesson_data[3][2], next_lesson_data[3][3])


# this functions need to be rewritten
func _load_last_page():
	print("your result is " + str(current_score))
	
	########Uncomment in Production########
	#Watchman.lesson_controller.save_data()




func _load_sound_lesson(question : String, right_answer : int, answer1 : String, answer2 : String, answer3 : String, answer4 : String):
	sound_lesson.load_info(question, right_answer, answer1, answer2, answer3, answer4)
	
	if(current_lesson != null):
		current_lesson.deinitialize()
	
	current_lesson = sound_lesson
	
	current_lesson.initialize()

# გადაეცემა კითხვა და სწორი პასუხი
func _load_text_lesson(question : String, right_answer : String):
	# write some function which will be loaded here
	
	if(current_lesson != null):
		current_lesson.deinitialize()
	
	current_lesson = text_lesson
	
	current_lesson.initialize()

# გადაეცემა კითხვა, სწორი პასუხის ნომერი, სავარაუდო პასუხები
func _load_quiz_lesson(question : String, right_answer : int, answer1 : String, answer2 : String, answer3 : String, answer4 : String):
	# load info
	
	if(current_lesson != null):
		current_lesson.deinitialize()
	
	current_lesson = quizz_lesson
	
	current_lesson.initialize()

# გადაეცემა კითხვა და სწორი პასუხის ინდექსი? მაგალითად თუ "ა" გადაეცა ჩატვირთავს ა.tsnc - ის?
func _load_write_lesson(question : String, right_answer : String):
	# load info
	
	if(current_lesson != null):
		current_lesson.deinitialize()
	
	current_lesson = write_lesson
	
	current_lesson.initialize()

