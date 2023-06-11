extends AudioStreamPlayer2D


func _ready() -> void:
	get_parent().connect("pressed", play)
