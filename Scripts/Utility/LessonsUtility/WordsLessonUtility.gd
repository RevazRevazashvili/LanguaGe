extends Lessons_util

class_name Words_lesson_util

var word_data : Word_saver			# შენახული ასოები

var chosen_words : Dictionary		# შერჩეული ასოები პლიუს ინფორმაცია მათ გავლილ გაკვეთილებზე

var practiced : Array[Word]			# ნავარჯიშები ასოების სია (chosen_letters იდან ამოყრილი დასწავლის შემდეგ)



func _ready() -> void:
	TYPE = Watchman.LESSON_TYPE.s_wrd
	lessons_count = 9


func initialize() -> void:
	_load_word_data();
	chosen_words = _choose_words()

func has_next_lesson():
	return !chosen_words.is_empty()

func get_next_lesson():
	var word = chosen_words.keys().front()
	var val = chosen_words.get(word)
	# თუ val = 0 ესეიგი არცერთი ტესტი არ გაუვლია	- ქვიზი უნდა გაიაროს
	# თუ val = 1 მაშინ მარტო ტესტი გაიარა 			- ხმა უნდა გაიაროს
	# თუ val = 2 მაშინ ტესტი და ხმა გაიარა			- უნდა დაწეროს
	# თუ დაწერა მაშინ ეს ასო ამოიშლება
	if val == 0:
		chosen_words[word] += 1
		return _get_sound_for(word) 
	
	if val == 1:
		chosen_words[word] += 1
		return _get_quiz_for(word)
	
	if val == 2:
		chosen_words.erase(word)
		practiced.append(word)
		return _get_text_for(word)

func save_data():
	for word in practiced:
		word.increment_practice()

	word_data.save_data()


func _load_word_data():
	word_data = Word_saver.load_data()

# ირჩევს სიტყვებს რენდომულად?
func _choose_words():
	var one = word_data.words[0]
	var two = word_data.words[1]
	var three = word_data.words[2]
	
	for word in word_data.words:
		if(one.eval() > word.eval()):
			if two.eval() > one.eval():
				if three.eval() > two.eval():
					three = two
				two = one
			one = word
		elif (two.eval() > word.eval()):
			if(three.eval() > two.eval()):
				three = two;
			two = word
		elif (three.eval() > word.eval()):
			three = word
	
	return {one : 0, two : 0, three : 0}


func _get_quiz_for(word : Word):
	# უნდა დავაბრუნოთ ტიპი 
	var type = Watchman.TEST_TYPE.quiz
	
	# უნდა დავაბრუნოთ კითხვა
	var question = word
	
	# უნდა დავაბრუნოთ 4 შესაძლო ვარიანტი
	var correct_index = randi_range(0,3)
	
	var rand_words = _get_3_random_words(word)
	
	var answers : Array
	
	var j = 0
	Watchman.data_dict = {}
	for i in range(0, 4):
		var wrd : Word
		if(i == correct_index):
			wrd = question
		else:
			wrd = rand_words[j]
			j += 1
		
		Watchman.data_dict[wrd.get_foreign()] = wrd.word
		
		answers.append(wrd.get_foreign())
	
	
	return [type, question.word, correct_index + 1, answers]

func _get_sound_for(word : Word):
	# უნდა დავაბრუნოთ ტიპი 
	var type = Watchman.TEST_TYPE.sound
	
	# უნდა დავაბრუნოთ კითხვა
	var question = word
	
	# უნდა დავაბრუნოთ 4 შესაძლო ვარიანტი
	var correct_index = randi_range(0,3)
	
	var rand_words = _get_3_random_words(word)
	
	var answers : Array
	
	var j = 0
	Watchman.data_dict = {}
	for i in range(0, 4):
		var wrd : Word
		if(i == correct_index):
			wrd = question
		else:
			wrd = rand_words[j]
			j += 1
		
		Watchman.data_dict[wrd.get_foreign()] = wrd.word
		
		answers.append(wrd.get_foreign())
	
	
	return [type, question.word, correct_index + 1, answers]

func _get_text_for(word : Word):
	# უნდა დავაბრუნოთ ტიპი 
	var type = Watchman.TEST_TYPE.text
	
	# უნდა დავაბრუნოთ კითხვა
	var question = word.word
	
	var answer = word.eng # დეფოლტად ინგლისური იყოს
	
	if(Watchman.current_language == Watchman.LANGUAGE.eng):
		answer = word.eng
	elif (Watchman.current_language == Watchman.LANGUAGE.rus):
		answer = word.rus
	
	return [type, question, answer]


func _get_3_random_words(word : Word):
	var result : Array[Word]
	
	var i = randi_range(0, word_data.words.size() - 1)
	
	var count = 0
	
	while(true):
		if count == 3:
			break
		
		var candidate = word_data.words[i];
		
		if candidate != word && (result.is_empty() || result.find(word) < 0):
			result.append(candidate)
			count += 1
		
		var rand = randi_range(1, 4);
		
		i = (i + rand) % word_data.words.size()
	
	return result


