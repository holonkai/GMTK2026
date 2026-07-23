extends CharacterBody2D

@export var movement_component : MovementComponent
@onready var hitbox: Area2D = $Hitbox


func _process(delta: float) -> void:
	hitbox.knock_back_dir = -movement_component.dir.normalized()
	if movement_component.dir.length() < 300:
		movement_component.get_recent_position()
	else:
		movement_component.chasing = true
	
