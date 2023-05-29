extends Node
# Me is singleton bitch


var setup_finished = false	# ცვლადი გვიჩვენებს საწყისი ჩატვირთვა მოხდა თუ არა

var current_header : String	# მიმდინარე სცენის სათაური (რაც თავში დაიწერება)

func _ready() -> void:
	#Loading.start_loading()
	Loading.connect("loading_cycle", initial_setup)
	
	var aqlemi = Data_saver.load_data()
	

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
	
	var timer = get_tree().create_timer(5)
	
	await timer.timeout 
	
	Loading.stop_loading_and_transition("res://Scenes/LessonMenu/LessonMenu.tscn")


func get_current_header():
	return current_header

func is_prevous_enabled():
	return SceneController.has_previous()
