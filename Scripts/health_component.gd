class_name HealthComponent extends Node

@export var max_health := 100.0
@export var body: CharacterBody2D

var current_health := 100.0

signal health_changed(max, current)
signal died()
func _ready() -> void:
	current_health = max_health
func take_damage(damage: float) -> void:
	current_health = clamp(current_health - damage, 0, max_health)
	if current_health == 0:
		died.emit()
	health_changed.emit(max_health, current_health)
	print(current_health)
