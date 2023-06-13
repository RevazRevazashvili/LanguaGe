extends Control



func _ready() -> void:
	$Control.get_node("Label").text = Watchman.get_current_header()
	$Control.get_node("TextureButton").visible = Watchman.is_prevous_enabled()
	

func _on_texture_button_pressed() -> void:
	SceneController.back_to_previous()
