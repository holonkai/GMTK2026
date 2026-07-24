class_name MovementComponent extends Node

@export var speed := 200
@export var attacking_speed := 400
@export var acceleration := 100
@export var body : CharacterBody2D
@export var sprite: AnimatedSprite2D
@onready var player_mechanics: Node2D = $"../../playerMechanics"

var can_move:= true
var dir := Vector2.ZERO
var chasing := true
var recent_pos := Vector2.ZERO

func _ready() -> void:
	pass



func _process(delta: float) -> void:
	if dir.x > 1:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	#constantly update the direction to the player
	dir = (player_mechanics.get_node("Player").global_position - body.global_position)
	if chasing and can_move:
		
		body.velocity = body.velocity.move_toward(dir.normalized() * speed, delta * acceleration)
	elif not chasing and can_move:
		body.velocity = body.velocity.move_toward(recent_pos * attacking_speed, delta * acceleration * 4)
	
	body.move_and_slide()
	
func get_recent_position():
	if chasing:
		recent_pos = (player_mechanics.get_node("Player").global_position - body.global_position).normalized()
		chasing = false
