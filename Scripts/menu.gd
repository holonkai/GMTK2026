extends Control

@onready var high_score_label: Label = $MarginContainer/VBoxContainer/HighScoreLabel

func _ready() -> void:
	var high_score := load_high_score()
	high_score_label.text = "High Score: " + str(high_score)

func load_high_score() -> int:
	var config := ConfigFile.new()
	var err := config.load("user://savegame.cfg")
	if err == OK:
		return config.get_value("save", "high_score", 0)
	return 0

func _on_start_pressed() -> void:
	#load the first level
	get_tree().change_scene_to_file("res://Scenes/background.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()
