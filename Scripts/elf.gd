extends CharacterBody2D

@onready var walking_movement_component: WalkingMovementComponent = $WalkingMovementComponent
@export var stats: EnemyStats
@onready var rightraycast: RayCast2D = $rightraycast
@onready var leftraycast: RayCast2D = $leftraycast
@onready var middleraycast: RayCast2D = $middleraycast
@onready var jumptimer: Timer = $jumptimer
@onready var firerate: Timer = $Firerate
@onready var bow: Marker2D = $bow
@onready var health_component: HealthComponent = $HealthComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $HealthBar
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var death_sfx: AudioStreamPlayer2D = $"Death SFX"

var can_shoot:= true
var arrow_speed:float 
var arrow = preload("res://Scenes/enemy_arrow.tscn")
var score_text = preload("res://Scenes/score.tscn")
var is_alive:= true
var has_jumped:= false

var gold_give: int
var score_amount: int
func _ready() -> void:
	walking_movement_component.SPEED = stats.speed
	walking_movement_component.JUMPHEIGHT = stats.jumpheight
	walking_movement_component.ACCELERATION = stats.acceleration
	health_component.max_health = stats.health
	health_component.current_health = health_component.max_health
	arrow_speed = stats.projectile_speed
	health_bar.max_value = health_component.max_health
	gold_give = stats.gold_drop
	score_amount = stats.points
func _process(delta: float) -> void:
	health_bar.value = health_component.current_health
	if not is_alive:
		return
	walking_movement_component.tick(delta)
	if not rightraycast.is_colliding() and walking_movement_component.dir.x > .1:
		walking_movement_component.jump()
		jumptimer.start()
		has_jumped = true
	elif not leftraycast.is_colliding() and walking_movement_component.dir.x < -.1:
		walking_movement_component.jump()
		jumptimer.start()
		has_jumped = true
	elif middleraycast.is_colliding() and not is_on_floor() and not has_jumped:
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
	audio_stream_player_2d.pitch_scale = randf_range(.8,1.2)
	audio_stream_player_2d.play(0.0)
	animated_sprite_2d.play("Fire")
	firerate.start()
	can_shoot = false
	var arrow_instance = arrow.instantiate()
	get_tree().current_scene.add_child(arrow_instance)
	arrow_instance.global_position = bow.global_position
	arrow_instance.direction = walking_movement_component.dir 
	arrow_instance.speed = arrow_speed


func _on_health_component_died() -> void:
	is_alive = false
	death_sfx.play(0.0)
	get_tree().get_first_node_in_group("Player").get_node_or_null("GoldManager").gain_gold(gold_give)
	get_tree().get_first_node_in_group("Player").get_node_or_null("ScoreManager").add_to_score(score_amount)
	var score_text_instance = score_text.instantiate()
	get_tree().current_scene.add_child(score_text_instance)
	score_text_instance.global_position = global_position - Vector2(50,100)
	score_text_instance.text = (str(score_amount) + "+")
	animated_sprite_2d.play("Death")


func _on_animated_sprite_2d_animation_finished() -> void:
	if is_alive:
		return
	queue_free()


func _on_firerate_timeout() -> void:
	can_shoot = true
