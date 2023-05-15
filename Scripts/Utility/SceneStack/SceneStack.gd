extends Node
class_name SceneStack
# სტეკში პირველი სცენა მიმდინარე სცენაა

var _scenes : Array


# აბრუნებს და შლის ბოლო ელემენტს სტეკიდან
func get_scene():
	return _scenes.pop_back()

# სტეკში ჩაამატებს გადაცემულ სცენის მისამართს
func push_scene(scene_path : String):
	_scenes.push_back(scene_path)

func size():
	return _scenes.size()

# აბრულებს ცარიელია თუ არა სტეკი
func is_empty():
	return _scenes.is_empty()

