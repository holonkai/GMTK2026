extends Control



func _on_start_pressed() -> void:
	#load the first level
	get_tree().change_scene_to_file("res://Scenes/background.tscn")
	pass # Replace with function body.

func _on_tutorial_pressed() -> void:
	pass # Replace with function body.
	
func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
