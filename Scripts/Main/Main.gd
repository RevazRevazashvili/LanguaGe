extends Node2D


func _on_button_pressed() -> void:
	print("button pressed")
	$Timer.start(5)
	LoadingScreen.start_loading("res://Scenes/LessonMenu/LessonMenu.tscn")
	await $Timer.timeout
	LoadingScreen.stop_loading()
