extends Control

@export
var lessons: Array[Lesson]			# მიმდინარე გაკვეთილში შემავალი ტესტები

@export
var last_page: Node					# ტესტის დამთავრების გვერდი რომელიც ყველა ტესტის გავლის შემდეგ გამოჩნდება

@onready
var lesson_space = $LessonsSpace	# ადგილი სადაც ტესტი ჩაიტვირთება


var current_lesson_index = 0		# მიმდინარე ტესტის ინდექსი lessons - მასივში

var current_score = 0


func _ready() -> void:
	#assert(!lessons.is_empty())
	
	for lesson in lessons:
		pass
		#lesson.connect("confirm_answer", _handle_answer)
	
	current_score = 0


func _handle_answer(answer: bool):
	if answer:
		current_score += 1
	
	if _has_next_lesson():
		_load_next_lesson()
	else:
		_load_last_page()


func _has_next_lesson():
	return lessons.size() < current_lesson_index

func _load_next_lesson():
	if(lessons.size() < current_lesson_index):
		_load_lesson_on(current_lesson_index + 1)

func _load_last_page():
	print("your result is " + current_score)
	pass

func _load_lesson_on(index : int):
	for child in lesson_space.get_children():
		child.queue_free()
	
	lesson_space.add_child(lessons[index])
	current_lesson_index = index

