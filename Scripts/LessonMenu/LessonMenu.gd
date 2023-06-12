extends Control


# we load icons and lessons identifiers from database
# all lesson click will transfer user to lessonsinterface
# but difference would be settings which will be set,
# for example: level of lessons tags of lessons and stuff like that

@onready
var swipe_menu = $SwipeMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	
	# according to this launch
	Watchman.load_lesson_interface_by_index(swipe_menu.card_current_index)
	
	



