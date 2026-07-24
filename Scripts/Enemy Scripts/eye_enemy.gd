extends CharacterBody2D

@export var movement_component : MovementComponent
@onready var hitbox: Area2D = $Hitbox
@onready var hurtbox: CollisionShape2D = $Hurtbox

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _process(delta: float) -> void:

	if movement_component.dir.length() < 300:
		movement_component.get_recent_position()
	else:
		movement_component.chasing = true
	


func _on_health_component_died() -> void:
	velocity = Vector2.ZERO
	movement_component.can_move = false
	hitbox.queue_free()
	hurtbox.queue_free()
	animated_sprite_2d.play("Death")
	


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
