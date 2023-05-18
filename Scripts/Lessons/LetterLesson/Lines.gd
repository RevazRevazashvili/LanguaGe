extends Lesson

@onready
var _lines = $Lines

var _pressed = false
var _current_line: Line2D


func _ready() -> void:
	var aqlemius :PackedVector2Array = PackedVector2Array()
	aqlemius.append(Vector2(100,100))
	aqlemius.append(Vector2(200,100))
	aqlemius.append(Vector2(200,200))
	aqlemius.append(Vector2(100,200))
	
	draw_letter(aqlemius)
	
	#if mouse entered but didn't leave then the thing is completed?
	#also add end and start positions
	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_esc"):
		clear()
	
	if event is InputEventMouseButton:
		_pressed = event.is_pressed()
		
		if _pressed:
			_current_line = Line2D.new()
			_current_line.add_to_group("lines")
			_current_line.default_color = Color.WHITE_SMOKE
			_current_line.width = 25
			_lines.add_child(_current_line)
	
	if event is InputEventMouseMotion && _pressed:
		_current_line.add_point(event.position)

func clear():
	for child in _lines.get_children():
			child.queue_free()


func draw_letter(array : PackedVector2Array):
	$Area2D2/CollisionPolygon2D.polygon = array
	
	
