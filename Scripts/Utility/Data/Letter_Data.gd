extends Resource
class_name Letter

@export
var letter : String

@export
var eng : String

@export
var rus : String

@export
var priority : int

@export
var practice : int



func eval():
	return practice + priority

func increment_practice():
	practice += 1

# აბრუნებს არჩეული უცხო ენოვან თარგმანს
func get_foreign():
	match Watchman.current_language:
		Watchman.LANGUAGE.eng: return eng
		Watchman.LANGUAGE.rus: return rus
