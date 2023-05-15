extends Control



func _ready() -> void:
	$Label.text = Watchman.get_current_header()
	$TextureButton.visible = Watchman.is_prevous_enabled()
	

func _on_texture_button_pressed() -> void:
	SceneController.back_to_previous()
