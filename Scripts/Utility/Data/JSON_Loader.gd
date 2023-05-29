extends Node
# could be depricated?

func load_json_file(file_path : String):
	if !FileAccess.file_exists(file_path):
		print("file doesn't exsists")
		return
	
	var data_file = FileAccess.open(file_path, FileAccess.READ)
	var parsed_result = JSON.parse_string(data_file.get_as_text())
	
	if parsed_result is Dictionary:
		return parsed_result
	else :
		print("error reading file")

