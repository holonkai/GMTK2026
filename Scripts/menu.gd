extends Control

func _on_start_pressed() -> void:
	#load the first level
	get_tree().change_scene_to_file("res://Scenes/background.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()
