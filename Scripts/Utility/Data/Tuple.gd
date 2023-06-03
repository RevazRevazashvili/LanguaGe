extends Node
class_name Tuple
# კლასი 3 ნებისმიერი ტიპის ცვლადის შესანახად

var _value1
var _value2
var _value3

func initialize(value1, value2, value3):
	_value1 = value1
	_value2 = value2
	_value3 = value3

func set_value(index, value):
	if index == 0:
		_value1 = value
	elif index == 1:
		_value2 = value
	elif index == 2:
		_value3 = value

func get_value(index):
	if index == 0:
		return _value1
	elif index == 1:
		return _value2
	elif index == 2:
		return _value3
