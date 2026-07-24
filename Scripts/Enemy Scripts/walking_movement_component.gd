class_name WalkingMovementComponent extends Node

@export var body: CharacterBody2D
@export var sprite: AnimatedSprite2D

var  SPEED:= 100
var ACCELERATION := 100
var friction := 500
var JUMPHEIGHT := 100
var GRAVITY := 200
var can_move := true
var dir: Vector2
var distance: Vector2

func tick(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("Player")
	if player == null:
		return
	var player_pos = player.global_position
	distance = (player_pos - body.global_position)
	dir = distance.normalized()
	if can_move: 
		if dir.x < -.1:
			sprite.flip_h = true
		elif dir.x > .1:
			sprite.flip_h = false
		body.velocity.x = move_toward(body.velocity.x, dir.x * SPEED, delta * ACCELERATION)
	elif not can_move:
		body.velocity.x = move_toward(body.velocity.x, 0, delta * friction)
		
	body.velocity.y += GRAVITY * delta
		
	body.move_and_slide()
	
	

func jump() -> void:
	if body.is_on_floor():
		body.velocity.y = -JUMPHEIGHT


	 
