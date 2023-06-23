extends Lessons_util

class_name Letters_lesson_util

var letter_data : Letter_saver		# შენახული ასოები

var chosen_letters : Dictionary		# შერჩეული ასოები პლიუს ინფორმაცია მათ გავლილ გაკვეთილებზე

var practiced : Array[Letter]		# ნავარჯიშები ასოების სია (chosen_letters იდან ამოყრილი დასწავლის შემდეგ)



func _ready() -> void:
	TYPE = Watchman.LESSON_TYPE.lett
	lessons_count = 9


func initialize() -> void:
	_load_letter_data();
	chosen_letters = _choose_letters()

func has_next_lesson():
	return !chosen_letters.is_empty()

func get_next_lesson():
	var lett = chosen_letters.keys().front()
	var val = chosen_letters.get(lett)
	# თუ val = 0 ესეიგი არცერთი ტესტი არ გაუვლია	- ქვიზი უნდა გაიაროს
	# თუ val = 1 მაშინ მარტო ტესტი გაიარა 			- ხმა უნდა გაიაროს
	# თუ val = 2 მაშინ ტესტი და ხმა გაიარა			- უნდა დაწეროს
	# თუ დაწერა მაშინ ეს ასო ამოიშლება
	if val == 0:
		chosen_letters[lett] += 1
		return _get_sound_for(lett) 
	
	if val == 1:
		chosen_letters[lett] += 1
		return _get_quiz_for(lett)
	
	if val == 2:
		chosen_letters.erase(lett)
		practiced.append(lett)
		return _get_text_for(lett)

func save_data():
	for letter in practiced:
		letter.increment_practice()
	
	letter_data.save_data()


func _load_letter_data():
	letter_data = Letter_saver.load_data()


func _choose_letters():
	var one = letter_data.letters[0]
	var two = letter_data.letters[1]
	var three = letter_data.letters[2]
	
	for letter in letter_data.letters:
		if(one.eval() > letter.eval()):
			if two.eval() > one.eval():
				if three.eval() > two.eval():
					three = two
				two = one
			one = letter
		elif (two.eval() > letter.eval()):
			if(three.eval() > two.eval()):
				three = two;
			two = letter
		elif (three.eval() > letter.eval()):
			three = letter
	
	return {one : 0, two : 0, three : 0}

func _get_quiz_for(letter : Letter):
	# უნდა დავაბრუნოთ ტიპი 
	var type = Watchman.TEST_TYPE.quiz
	
	# უნდა დავაბრუნოთ კითხვა
	var question = letter
	
	# უნდა დავაბრუნოთ 4 შესაძლო ვარიანტი
	var correct_index = randi_range(0,3)
	
	var rand_letters = _get_3_random_letters(letter)
	
	var answers : Array
	
	var j = 0
	Watchman.data_dict = {}
	for i in range(0, 4):
		var lett : Letter
		if(i == correct_index):
			lett = question
		else:
			lett = rand_letters[j]
			j += 1
		
		Watchman.data_dict[lett.get_foreign()] = lett.letter
		
		answers.append(lett.get_foreign())
	
	
	return [type, question.letter, correct_index + 1, answers]

func _get_sound_for(letter : Letter):
	# უნდა დავაბრუნოთ ტიპი 
	var type = Watchman.TEST_TYPE.sound
	
	# უნდა დავაბრუნოთ კითხვა
	var question = letter
	
	# უნდა დავაბრუნოთ 4 შესაძლო ვარიანტი
	var correct_index = randi_range(0,3)
	
	var rand_letters = _get_3_random_letters(letter)
	
	var answers : Array
	
	var j = 0
	Watchman.data_dict = {}
	for i in range(0, 4):
		var lett : Letter
		if(i == correct_index):
			lett = question
		else:
			lett = rand_letters[j]
			j += 1
		
		Watchman.data_dict[lett.get_foreign()] = lett.letter
		
		answers.append(lett.get_foreign())
	
	
	return [type, question.letter, correct_index + 1, answers]

func _get_text_for(letter : Letter):
	# უნდა დავაბრუნოთ ტიპი 
	var type = Watchman.TEST_TYPE.text
	
	# უნდა დავაბრუნოთ კითხვა
	var question = letter.letter
	
	var answer = letter.eng # დეფოლტად ინგლისური იყოს
	
	if(Watchman.current_language == Watchman.LANGUAGE.eng):
		answer = letter.eng
	elif (Watchman.current_language == Watchman.LANGUAGE.rus):
		answer = letter.rus
	
	return [type, question, answer]


func _get_3_random_letters(letter : Letter):
	var result : Array[Letter]
	
	var i = randi_range(0, letter_data.letters.size() - 1)
	
	var count = 0
	
	while(true):
		if count == 3:
			break
		
		var candidate = letter_data.letters[i];
		
		if candidate != letter && (result.is_empty() || result.find(letter) < 0):
			result.append(candidate)
			count += 1
		
		var rand = randi_range(1, 4);
		
		i = (i + rand) % letter_data.letters.size()
	
	return result


