class_name MovementComponent extends Node

@export var speed := 200
@export var body : CharacterBody2D
@onready var player_mechanics: Node2D = $"../../playerMechanics"

var dir := Vector2.ZERO
func _ready() -> void:
	pass



func _process(delta: float) -> void:
	
	dir = (player_mechanics.get_node("Player").global_position - body.global_position).normalized()
	
	body.velocity = dir * speed 
	
	body.move_and_slide()
	print(body.velocity)
	
