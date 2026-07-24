extends Node2D

@onready var arrow_loc: Marker2D = $ArrowLoc
@onready var fire_rate: Timer = $FireRate

var arrow := preload("res://Scenes/arrow.tscn")
@export var arrow_speed := 100
var wants_shoot:= false
var can_shoot := true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):
		wants_shoot = true
	if Input.is_action_just_released("Shoot"):
		wants_shoot = false



func _physics_process(delta: float) -> void:
	if wants_shoot and can_shoot:
		shoot()
		


func shoot() -> void:
	fire_rate.start()
	can_shoot = false
	var arrow_instance = arrow.instantiate()
	get_tree().current_scene.add_child(arrow_instance)

	arrow_instance.global_position = arrow_loc.global_position

	arrow_instance.set_direction((get_global_mouse_position() - arrow_instance.global_position).normalized())


func _on_fire_rate_timeout() -> void:
	can_shoot = true
