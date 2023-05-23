extends Node2D

const RESOURCE_FOLDER_PATH = "res://Resources"	# გზა რესურსების ფოლდერისკენ

func get_letter_icon_path(letter : String):
	return (RESOURCE_FOLDER_PATH + "/Letter_icons/" + letter + ".png")

func get_letter_sound_path(letter : String):
	return (RESOURCE_FOLDER_PATH + "/Letter_sounds/" + letter + ".mp3")
