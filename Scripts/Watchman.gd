extends Node
# Me is singleton bitch


enum TEST_TYPE{quiz, sound, text}	# გვიჩვენებს გაკვეთილში ტესტის ტიპს

enum LESSON_TYPE {lett, s_wrd, mixd}	# გვიჩვენებს ჩასატვირთი გაკვეთილის ტიპს

var lessons_enums : Array[LESSON_TYPE]	# ჩასატვირთი გაკვეთილების სია

var lesson_controller : Lessons_util	# მიდინარე ჩატვირთული გაკვეთილის კონტროლერი (მაში შედის ინფორმაცია რა დათა ჩაიტვირტება გაკვეთილში და როგორი)



var setup_finished = false	# ცვლადი გვიჩვენებს საწყისი ჩატვირთვა მოხდა თუ არა

var current_header : String	# მიმდინარე სცენის სათაური (რაც თავში დაიწერება)



func _ready() -> void:
	#Loading.start_loading()
	Loading.connect("loading_cycle", initial_setup)
	
	#Data_saver.new().save_data()
	
	#var aqlemi = Data_saver.load_data()

# საწყისი ჩატვირთვის დორს განხორციელებული ფუნქცია
func initial_setup():
	if setup_finished:
		return
	SceneController.inital_load()
	Loading.stop_loading()
	setup_finished = true


func test_transition_to(path : String):
	get_tree().change_scene_to_packed(load(path))
	#Loading.start_loading(path)
	#ss.push(path)
	#Loading.stop_loading()


func go_to_unit_1():
	Loading.start_loading()
	current_header = "Unit 1"
	
	# load info about unit 1 from database
	# info will include:
	# - array of lesson tags (eg. 1-st will be (letters, sound lessons), 2-nd (simple_words, translations, ect.)
	# these tags will be loaded into json file
	
	#data = Data_saver.load_data()
	
	# loading appropriate lessons
	lessons_enums = [LESSON_TYPE.lett, LESSON_TYPE.s_wrd, LESSON_TYPE.mixd]
	
	
	
	var timer = get_tree().create_timer(1)
	
	await timer.timeout
	
	Loading.stop_loading_and_transition("res://Scenes/LessonMenu/LessonMenu.tscn")


func get_current_header():
	return current_header

func is_prevous_enabled():
	return SceneController.has_previous()



func load_lesson_interface_by_index(index : int):
	load_lesson_interface(lessons_enums[index])


func load_lesson_interface(lesson : LESSON_TYPE):
	match lesson:
		LESSON_TYPE.lett: _load_letters_lessons()
		LESSON_TYPE.s_wrd: _load_simple_words_lessons()
		LESSON_TYPE.mixd: _load_practice_lessons()


func _load_letters_lessons():
	# გაუშვათ ლოადინგი
	Loading.start_loading()
	
	lesson_controller = Letters_lesson_util.new()
	
	lesson_controller.initialize()
	
	Loading.stop_loading_and_transition("res://Scenes/Lessons/LessonsInterface.tscn")


func _load_simple_words_lessons():
	print("simple words!!")
	pass

func _load_practice_lessons():
	pass

