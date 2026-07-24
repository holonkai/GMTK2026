extends CharacterBody2D

@onready var walking_movement_component: WalkingMovementComponent = $WalkingMovementComponent
@export var stats: EnemyStats
@onready var right_ray_cast: RayCast2D = $RightRayCast
@onready var left_ray_cast: RayCast2D = $LeftRayCast
@onready var middle_ray_cast: RayCast2D = $MiddleRayCast
@onready var jump_timer: Timer = $"Jump Timer"
@onready var fire_rate: Timer = $"Fire Rate"
@onready var staff: Marker2D = $Staff
@onready var health_component: HealthComponent = $HealthComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var can_shoot:= true
var fireball_speed:float 
var fireball = preload("res://Scenes/fire_ball.tscn")
var is_alive:= true
var has_jumped:= false

func _ready() -> void:
	walking_movement_component.SPEED = stats.speed
	walking_movement_component.JUMPHEIGHT = stats.jumpheight
	walking_movement_component.ACCELERATION = stats.acceleration
	health_component.max_health = stats.health
	health_component.current_health = health_component.max_health
	fireball_speed = stats.projectile_speed
func _process(delta: float) -> void:
	if not is_alive:
		return
	walking_movement_component.tick(delta)
	if not right_ray_cast.is_colliding() and walking_movement_component.dir.x > .1:
		walking_movement_component.jump()
		jump_timer.start()
		has_jumped = true
	elif not left_ray_cast.is_colliding() and walking_movement_component.dir.x < -.1:
		walking_movement_component.jump()
		jump_timer.start()
		has_jumped = true
	elif middle_ray_cast.is_colliding() and not is_on_floor() and not has_jumped:
		walking_movement_component.can_move = false
	elif walking_movement_component.distance.length() < 400:
		if can_shoot:
			shoot()
		walking_movement_component.can_move = false
	else:
		walking_movement_component.can_move = true
	

func _on_jump_timer_timeout() -> void:
	has_jumped = false

func shoot():
	fire_rate.start()
	can_shoot = false
	var fire_ball_instance = fireball.instantiate()
	get_tree().current_scene.add_child(fire_ball_instance)

	fire_ball_instance.global_position = staff.global_position
	fire_ball_instance.direction = walking_movement_component.dir 
	fire_ball_instance.speed = fireball_speed

func _on_fire_rate_timeout() -> void:
	can_shoot = true


func _on_health_component_died() -> void:
	animated_sprite_2d.play("Death")


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
