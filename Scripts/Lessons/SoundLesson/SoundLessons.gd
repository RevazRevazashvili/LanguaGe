extends Lesson

@export_category("Loadables")

@export
var right_answer : int

@export
var question : String	# აქ იწერება ასო მაგრამ ჩაიტვირთება მხოლოდ ხმა

@export
var answer1 : String
@export
var answer2 : String
@export
var answer3 : String
@export
var answer4 : String



@onready
var question_audio = $VBoxContainer/TopPart/Button/Audio


@onready
var button_one : Button = $VBoxContainer/BottomPart/HBoxContainer/VBoxContainer/Answer1

@onready
var button_two : Button = $VBoxContainer/BottomPart/HBoxContainer/VBoxContainer/Answer2

@onready
var button_three : Button = $VBoxContainer/BottomPart/HBoxContainer/VBoxContainer2/Answer3

@onready
var button_four : Button = $VBoxContainer/BottomPart/HBoxContainer/VBoxContainer2/Answer4


func _ready() -> void:
	load_answers()
	load_question()


func load_answers():
	if(!answer1.is_empty()):
		# ტექსტურის ჩატვირთვა
		button_one.icon = load(DataManager.get_letter_icon_path(answer1))
		
		# ხმის ჩატვირთვა
		var audio = button_one.get_child(0) as AudioStreamPlayer2D
		audio.stream = load(DataManager.get_letter_sound_path(answer1))
		
	if(!answer2.is_empty()):
		# ტექსტურის ჩატვირთვა
		button_two.icon = load(DataManager.get_letter_icon_path(answer2))
		
		# ხმის ჩატვირთვა
		var audio = button_two.get_child(0) as AudioStreamPlayer2D
		audio.stream = load(DataManager.get_letter_sound_path(answer2))
	
	if(!answer3.is_empty()):
		# ტექსტურის ჩატვირთვა
		button_three.icon = load(DataManager.get_letter_icon_path(answer3))
		
		# ხმის ჩატვირთვა
		var audio = button_three.get_child(0) as AudioStreamPlayer2D
		audio.stream = load(DataManager.get_letter_sound_path(answer3))
	
	if(!answer4.is_empty()):
		# ტექსტურის ჩატვირთვა
		button_four.icon = load(DataManager.get_letter_icon_path(answer4))
		
		# ხმის ჩატვირთვა
		var audio = button_four.get_child(0) as AudioStreamPlayer2D
		audio.stream = load(DataManager.get_letter_sound_path(answer4))

func load_question():
	if(!question.is_empty()):
		# ხმის ჩატვირთვა
		question_audio.stream = load(DataManager.get_letter_sound_path(question))


func _on_answer_1_pressed() -> void:
	button_one.button_pressed = true
	button_two.button_pressed = false
	button_three.button_pressed = false
	button_four.button_pressed = false

func _on_answer_2_pressed() -> void:
	button_one.button_pressed = false
	button_two.button_pressed = true
	button_three.button_pressed = false
	button_four.button_pressed = false

func _on_answer_3_pressed() -> void:
	button_one.button_pressed = false
	button_two.button_pressed = false
	button_three.button_pressed = true
	button_four.button_pressed = false

func _on_answer_4_pressed() -> void:
	button_one.button_pressed = false
	button_two.button_pressed = false
	button_three.button_pressed = false
	button_four.button_pressed = true
