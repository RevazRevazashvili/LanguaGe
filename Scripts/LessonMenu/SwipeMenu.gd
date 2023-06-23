extends ScrollContainer

@export_range(0.5, 1, 0.1)
var card_scale = 1

@export_range(1, 1.5, 0.1)
var card_current_scale = 1.25

@export_range(0.1, 1, 0.1)
var scroll_duration = 0.5

var card_current_index: int = 0
var card_x_position: Array = []

@onready
var scroll_tween

@onready
var margin_r: int = $CenterContainer/MarginContainer.get("theme_override_constants/margin_right")
@onready
var card_space: int = $CenterContainer/MarginContainer/HBoxContainer.get("theme_override_constants/separation")
@onready
var card_nodes: Array = $CenterContainer/MarginContainer/HBoxContainer.get_children()

var ready_complete = false

func _ready() -> void:
	await get_tree().process_frame
	
	get_h_scroll_bar().modulate.a = 0
	
	for _card in card_nodes:
		var _card_pos_x: float = (margin_r + _card.position.x) - ((size.x - _card.size.x)/2)
		_card.pivot_offset = (_card.size / 2)
		card_x_position.append(_card_pos_x)
	
	scroll_horizontal = card_x_position[card_current_index]
	scroll()
	ready_complete = true


func _process(delta: float) -> void:
	for _index in range(card_x_position.size()):
		var _card_pos_x: float = card_x_position[_index]
		var _swipe_length: float = (card_nodes[_index].size.x / 2) + (card_space / 2)
		var _swipe_current_length: float = abs(_card_pos_x - scroll_horizontal)
		var _card_scale: float = range_lerp(_swipe_current_length, _swipe_length, 0, card_scale, card_current_scale)
		var _card_opacity: float = range_lerp(_swipe_current_length, _swipe_length, 0, 0.3, 1)

		_card_scale = clamp(_card_scale, card_scale, card_current_scale)
		_card_opacity = clamp(_card_opacity, 0.3, 1)

		card_nodes[_index].scale = Vector2(_card_scale, _card_scale)
		card_nodes[_index].modulate.a = _card_opacity
	
		if _swipe_current_length < _swipe_length:
			card_current_index = _index
	


func range_lerp(value, min1, min2, max1, max2):
	return min2 + (max2 - min2) * ((value - min1) / (max1 - min1))


func scroll() -> void:
	scroll_tween = create_tween().parallel()
	scroll_tween.tween_property(
		self,
		"scroll_horizontal",
		card_x_position[card_current_index],
		scroll_duration
		).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	for _index in range(card_nodes.size()):
		var _card_scale: float = card_current_scale if _index == card_current_index else card_scale
		scroll_tween.tween_property(
			card_nodes[_index],
			"scale",
			Vector2(_card_scale, _card_scale),
			scroll_duration
		).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			scroll_tween.stop()
		else:
			scroll()


func _on_lesson_menu_resized() -> void:
	if !ready_complete: return
	
	await get_tree().process_frame
	
	card_x_position = []
	
	get_h_scroll_bar().modulate.a = 0
	
	for _card in card_nodes:
		var _card_pos_x: float = (margin_r + _card.position.x) - ((size.x - _card.size.x)/2)
		_card.pivot_offset = (_card.size / 2)
		card_x_position.append(_card_pos_x)
		print(_card_pos_x)
	
	scroll_horizontal = card_x_position[card_current_index]
	scroll()
