extends Node
# ტესტის კლასი რომლის შვილიც იქნება ყველა ტესტები
class_name Lesson

signal answered(correct) # იგზავნება როცა ტესტის პასუხის გაცემა მოხდება


func confirm_answer(result: bool):
	emit_signal("answered", {result=true})

