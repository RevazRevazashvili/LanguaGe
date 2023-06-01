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
