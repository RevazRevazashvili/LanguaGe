extends Node2D
# ეს კლასი არის განკუთვნილი რესურსებთან წვდომისთვის
# იგი არ ახდენს რესურსების ჩატვირთვას უბრალოდ გვაძლევს საშუალებებს მათ მივწვდეთ

const RESOURCE_FOLDER_PATH = "res://Resources"	# გზა რესურსების ფოლდერისკენ


# აბრუნებს გადაცემული ასობგერის იკონკის გზას ფაილურ სისტემაში
func get_letter_icon_path(letter : String):
	return (RESOURCE_FOLDER_PATH + "/Letter_icons/" + letter + ".png")

# აბრუნებს გადაცემული ასობგერის ხმის გზას ფაილურ სისტემაში
func get_letter_sound_path(letter : String):
	return (RESOURCE_FOLDER_PATH + "/Letter_sounds/" + letter + ".mp3")

# აბრუნებს გადაცემული სახელის მქონე ხმას
func get_sound_path(name : String):
	return (RESOURCE_FOLDER_PATH + "/sounds/" + name + ".mp3")
