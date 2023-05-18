extends Control

@export
var ANIMATION_REPEAT_INTERVAL : float	# გვიჩვენებს რამდენ წამში მეორდება ლოად ანიმაცია

@onready
var _anim_player = $AnimationPlayer	# ანიმაციის პლეიერის ცვლადი
@onready
var _timer = $Timer					# ტაიმერის რეფერენც ცვლადი


func _ready() -> void:
	Loading.connect("loading_start", _on_loading_start)
	Loading.connect("loading_stop", _on_loading_stop)


# გამოიძახება როდესაც Loading გლობალური კლასი გამოსცემს loading_start სიგნალს
func _on_loading_start():
	pass

func _on_loading_stop():
	pass

# ეს ორი ფუნქცია წარმოადგენს ანიმაციის ციკლს
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "Load"):
		_timer.start(ANIMATION_REPEAT_INTERVAL)
		Loading.emit_signal("loading_cycle")

func _on_timer_timeout() -> void:
	_anim_player.play("Load")
