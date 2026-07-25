extends Node2D

var health_bottle = preload("res://Scenes/health_drop.tscn")
var damage_bottle = preload("res://Scenes/damage.tscn")
var speed_bottle = preload("res://Scenes/speed.tscn")
var double_jump = preload("res://Scenes/double_jump.tscn")

var drops:=[]
var first_spawn := true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drops = [health_bottle, speed_bottle, damage_bottle]


func _on_drops_timer_timeout() -> void:
	var player_pos = get_tree().get_first_node_in_group("Player").global_position
	if first_spawn:
		var double_jump_instance = double_jump.instantiate()
		get_tree().current_scene.add_child(double_jump_instance)
		double_jump_instance.global_position = player_pos - Vector2(randf_range(-500,500), randf_range(-500, 500))
		first_spawn = false
		return
	#spawn random drop
	var drop = drops[randi_range(0,len(drops) -1)].instantiate()
	get_tree().current_scene.add_child(drop)
	drop.global_position = player_pos - Vector2(randf_range(-500,500), randf_range(-500, 500))
	
