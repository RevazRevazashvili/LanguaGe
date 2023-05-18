extends Node
# ეს კლასი აკონტროლებს ჩატვირთვას 
# თუ ჩატვირთვას ვახდენთ start_loading ფუნქციას ვიძახებთ
# ჩატვირთვის დამთავრების შემდეგ კი stop_loading - ს

const PATH_TO_LOADING_SCENE = "res://Scenes/Loading/LoadingScene.tscn"	# ლოადინგის სცენის მიმთითებელი path - ი

var _loading : bool = false	# გვიჩვენებს ლოადინგი ხდება თუ არა (true - ლოადინგის პროცესშია, false - წინააღმდეგ შემთხვევაში)


signal loading_start	# სიგნალი რომელიც გამოიცემა როცა ლოადინგი იწყება
signal loading_stop		# სიგნალი რომელიც გამოიცემა როცა ლოადინგი ჩერდება
signal loading_cycle	# სიგნალი რომელიც გამოიყოფა ლოადინგ ანიმაციის ყოველ ციკლზე (ანიმაციის ბოლოს)

# იწყებს ლოადინგს გადართავს სცენას ლოადინგ სცენაზე
# გამოსცემს loading_start სიგნალს
func start_loading():
	if(_loading): # თუ ჩატვირთვის მდგომარეობაშია თავიდან ვერ ჩავტვირთავთ
		return
	SceneController.change_scene_without_record(PATH_TO_LOADING_SCENE)
	_loading = true
	emit_signal("loading_start")


# ამთავრებს ლოადინგს, სცენის გადართვას არ ახდენს
# გამოსცემს სიგნალს loading_stop
func stop_loading():
	if(_loading): # თუ ჩატვირთვა არ ხდება პირდაპირ გადართვას ვერ გავაკეთებთ
		_loading = false
		emit_signal("loading_stop")


# ამთავრებს ლოადინგს და გადაირთვება გადაცემულ სცენაზე
# გამოსცემს სიგნალს loading_stop
func stop_loading_and_transition(scene : String):
	stop_loading()
	SceneController.change_scene(scene)

