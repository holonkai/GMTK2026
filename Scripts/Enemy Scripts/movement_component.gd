class_name MovementComponent extends Node

@export var speed := 200
@export var acceleration := 50
@export var body : CharacterBody2D
@onready var player_mechanics: Node2D = $"../../playerMechanics"

var dir := Vector2.ZERO
var chasing := true
var recent_pos := Vector2.ZERO
func _ready() -> void:
	pass



func _process(delta: float) -> void:
	#constantly update the direction to the player
	dir = (player_mechanics.get_node("Player").global_position - body.global_position)
	if chasing:
		print("I'm chasing")
		body.velocity = body.velocity.move_toward(dir.normalized() * speed, delta * acceleration)
	else:
		print("I'm attacking")
		body.velocity = body.velocity.move_toward(recent_pos * speed, delta * acceleration)
	
	body.move_and_slide()
	
func get_recent_position():
	if chasing:
		print("imma get ya")
		recent_pos = (player_mechanics.get_node("Player").global_position - body.global_position).normalized()
		chasing = false
