extends Lesson
class_name WritingLesson

@export
var right_answer : String

@export
var question : String


@onready
var question_label : TextEdit = $VBoxContainer/TopPart/Text

@onready
var answer_field : TextEdit = $VBoxContainer/BottomPart/MarginContainer/AnswerField

func initialize():
	answer_field.connect("text_changed", _answer_written)
	
	load_question()
	self.visible = true

func deinitialize():
	answer_field.disconnect("text_changed", _answer_written)
	
	question_label.text = ""
	answer_field.text = ""
	
	self.visible = false


func load_info(question : String, right_answer : String):
	self.question = question
	self.right_answer = right_answer

func load_question():
	if(!question.is_empty()):
		question_label.text = question

func is_selected_correct():
	return right_answer.capitalize() == answer_field.text.capitalize()

func _answer_written():
	if(!answer_field.text.is_empty()):
		emit_signal("selected")
	else:
		emit_signal("deselected")
