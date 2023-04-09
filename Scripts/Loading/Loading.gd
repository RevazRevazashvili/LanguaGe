extends CanvasLayer

# _armed : boolean - shows is loading screen is showing and can be stopped
var _armed = false
var _next_scene

# shows loading screen, starts loading animation and sets armed to true.
func start_loading(target: String):
	$AnimationPlayer.play("Loading...-loop")
	_next_scene = target
	_armed = true

# hides loading screen, and transitions to next scene indicated in _next_scene variable
func stop_loading():
	if(_armed):
		_armed = false
		$AnimationPlayer.play("RESET")
		get_tree().change_scene_to_file(_next_scene)
		_next_scene = null



