extends Lesson
class_name SoundLesson 

@export
var right_answer : int

var question

var answer1
var answer2
var answer3
var answer4


@onready
var question_audio = $VBoxContainer/TopPart/Button/Audio

@onready 
var question_button = $VBoxContainer/TopPart/Button

@onready
var button_one : Button = $VBoxContainer/BottomPart/HBoxContainer/VBoxContainer/Answer1

@onready
var button_two : Button = $VBoxContainer/BottomPart/HBoxContainer/VBoxContainer/Answer2

@onready
var button_three : Button = $VBoxContainer/BottomPart/HBoxContainer/VBoxContainer2/Answer3

@onready
var button_four : Button = $VBoxContainer/BottomPart/HBoxContainer/VBoxContainer2/Answer4


var _selected_answer : int	# გვიჩვენებს რომელი პასუხია არჩეული (0 ნიშნავს რომ არაა პასუხი არჩეული)



func initialize():
	_selected_answer = 0
	
	load_answers()
	load_question()
	self.visible = true

func deinitialize():
	self.visible = false
	button_one.button_pressed = false
	button_two.button_pressed = false
	button_three.button_pressed = false
	button_four.button_pressed = false

func load_info(question, right_answer : int, answer1, answer2, answer3, answer4):
	self.question = question
	self.right_answer = right_answer
	self.answer1 = answer1
	self.answer2 = answer2
	self.answer3 = answer3
	self.answer4 = answer4


func load_answers():
	if(!answer1.is_empty()):
		# ტექსტურის ჩატვირთვა
		button_one.text = answer1
		
		# ხმის ჩატვირთვა
		load_audio_on(button_one, answer1)
		
	if(!answer2.is_empty()):
		# ტექსტურის ჩატვირთვა
		button_two.text = answer2
		
		# ხმის ჩატვირთვა
		load_audio_on(button_two, answer2)
	
	if(!answer3.is_empty()):
		# ტექსტურის ჩატვირთვა
		button_three.text = answer3
		
		# ხმის ჩატვირთვა
		load_audio_on(button_three, answer3)
	
	if(!answer4.is_empty()):
		# ტექსტურის ჩატვირთვა
		button_four.text = answer4
		
		# ხმის ჩატვირთვა
		load_audio_on(button_four, answer4)


func load_question():
	if(!question.is_empty()):
		# ტექსტის ჩატვირთვა
		question_button.text = question
		question_button.icon = null
		
		# ხმის ჩატვირთვა
		question_audio.stream = load(DataManager.get_letter_sound_path(question))


func load_audio_on(button, audio_label):
	var audio = button.get_child(0) as AudioStreamPlayer2D
	audio.stream = load(DataManager.get_letter_sound_path(Watchman.data_dict[audio_label]))


func check_if_answered():
	return _selected_answer != 0

func is_selected_correct():
	return right_answer == _selected_answer


func _on_answer_1_pressed() -> void:
	_selected_answer = 1
	emit_signal("selected")
	button_one.button_pressed = true
	button_two.button_pressed = false
	button_three.button_pressed = false
	button_four.button_pressed = false

func _on_answer_2_pressed() -> void:
	_selected_answer = 2
	emit_signal("selected")
	button_one.button_pressed = false
	button_two.button_pressed = true
	button_three.button_pressed = false
	button_four.button_pressed = false

func _on_answer_3_pressed() -> void:
	_selected_answer = 3
	emit_signal("selected")
	button_one.button_pressed = false
	button_two.button_pressed = false
	button_three.button_pressed = true
	button_four.button_pressed = false

func _on_answer_4_pressed() -> void:
	_selected_answer = 4
	emit_signal("selected")
	button_one.button_pressed = false
	button_two.button_pressed = false
	button_three.button_pressed = false
	button_four.button_pressed = true
