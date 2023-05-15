extends Node
# ეს კლასი არის სცენების კონტროლერი 
# ყველა სცენის ცვლილების გამოძახება ხდება ამ კლასის ფუნქციებთან წვდომით
#class_name SceneController

const PATH_TO_TOP_TOOLBAR = "res://Scenes/TopBar/TopBar.tscn" # გზა რომელიც ზედა ტულბარს მიუთითებს

const PATH_TO_HOME_SCENE = "res://Scenes/Main/Main.tscn"

signal scene_changed	# გამოიცემა როცა მიმდინარე სცენა იცვლება

@onready
var scene_stack = SceneStack.new() # სცენების სტეკი


# გამოიყენება პირველი ჩატვირთვის დროს გადართავს სცენას მთავარ სცენაზე
func inital_load():
	_transition_to(PATH_TO_HOME_SCENE)
	scene_stack.push_scene(PATH_TO_HOME_SCENE)
	emit_signal("scene_changed")

# ცვლის მიმდინარე სცენას გადაცემულით (ინახავს მიმდინარე სცენას სტეკში)
func change_scene(scene : String):
	scene_stack.push_scene(scene)
	
	_transition_to(scene)
	emit_signal("scene_changed")

# შეცვლის მიმდინარე სცენას და არ შეინახავს scene_stack - ში
func change_scene_without_record(scene : String):
	_transition_to(scene)
	emit_signal("scene_changed")


# გადართავს მიმდინარე სცენას წინა სცენაზე (ჩაწერილს სტეკში)
# აბრუნებს true - თუ გადართვა წარმატებულია (გვაქვს წინა სცენა)
# აბრუნებს false - თუ წინა სცენა არ არსებობს
# გადართვის შემთხვევაში გამოსცემს scene_changed სიგნალს
func back_to_previous():
	if !has_previous():
		return false
	
	var curr_scene = scene_stack.get_scene() # ჯერ მიმდინარეს ამოვაგდებთ
	var prev_scene = scene_stack.get_scene() # მერე წინას
	
	change_scene(prev_scene)
	
	return true

# გვიჩვნებს გვაქვს თუ არა წინა სცენა
func has_previous():
	return scene_stack.size() > 1


# სცენის გადართვის უტილიტა
func _transition_to(scene_path: String):
	get_tree().change_scene_to_file(scene_path)

