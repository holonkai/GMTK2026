extends Node2D

@onready var increase_enemies: Timer = $"Increase enemies"
@onready var control: Control = $Control
@onready var spawn_rate: Timer = $EnemySpawner/SpawnRate


func _on_increase_enemies_timeout() -> void:
	spawn_rate.wait_time = 4
	control.visible = true
	await get_tree().create_timer(2).timeout
	control.visible = false
	increase_enemies.start()
