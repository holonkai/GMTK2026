extends Node2D

var score: int
var high_score: int
var enemies_killed: int

@onready var score_text: Label = $"../IGUI/Score"
@onready var high_score_text: Label = $"../IGUI/HighScore"

const SAVE_PATH := "user://savegame.cfg"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	high_score = load_high_score()
	high_score_text.text = "High Score: " + str(high_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_text.text = "Score: " + str(score)
	if score > high_score:
		high_score = score
		high_score_text.text = "High Score: " + str(high_score)
		save_high_score()

func add_to_score(amount: int) -> void:
	score += amount

func load_high_score() -> int:
	var config := ConfigFile.new()
	var err := config.load(SAVE_PATH)
	if err == OK:
		return config.get_value("save", "high_score", 0)
	return 0
	
func save_high_score() -> void:
	var config := ConfigFile.new()
	config.load(SAVE_PATH)
	config.set_value("save", "high_score", high_score)
	config.save(SAVE_PATH)
