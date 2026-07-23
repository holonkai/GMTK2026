extends CharacterBody2D

@export var movement_component : MovementComponent

func _process(delta: float) -> void:
	if movement_component.dir.length() < 200:
		movement_component.get_recent_position()
	else:
		movement_component.chasing = true
	
