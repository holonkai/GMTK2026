extends Node2D

var score: int
var high_score: int
var enemies_killed: int

@onready var score_text: Label = $"../IGUI/Score"
@onready var high_score_text: Label = $"../IGUI/HighScore"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set the high score to the saved high score
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_text.text = ("Score: " + str(score))
	if score > high_score:
		high_score_text.text = ("High Score: " + str(score))

func add_to_score(amount: int) -> void:
	score += amount
