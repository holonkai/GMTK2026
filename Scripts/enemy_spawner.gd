extends Node2D

#preloads the enemies
const MAGE = preload("res://Scenes/mage.tscn")
const EYE = preload("res://Scenes/EyeEnemy.tscn")

var enemies := []
#puts all the enemies in an array
func _ready() -> void:
	enemies = [MAGE, EYE]

@onready var spawn_rate: Timer = $SpawnRate

func spawn_enemy() -> void:
	#random enemy and spawns it
	var i = randi_range(0, len(enemies) -1)
	var enemy = enemies[i].instantiate()
	add_child(enemy)
	#puts the enemy at a random distance from the player
	enemy.global_position = (get_tree().get_first_node_in_group("Player").global_position) - Vector2(randf_range(100,500), randf_range(100,500))
	spawn_rate.start()

func _on_spawn_rate_timeout() -> void:
	spawn_enemy()
