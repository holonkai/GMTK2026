extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sfx: AudioStreamPlayer2D = $JumpSFX
@onready var pause_menu: Control = $PauseMenu
@onready var gold_manager: Node2D = $GoldManager
@onready var health_component: HealthComponent = $HealthComponent
@onready var health_bar: ProgressBar = $IGUI/HealthBar


const SPEED := 300.0
const FRICTION := 1200.0
const ACCELERATION := 800.0
const JUMP_VELOCITY := -1500.0

@export var damage: float
@export var arrow_speed: float
@export var loss_amount:= 50
@export var gain_amount:= 100
var old_health: float

func _ready() -> void:
	pause_menu.hide()
	old_health = health_component.max_health
	
func _dead():
	pass
	
func _physics_process(delta: float) -> void:
	var bow = get_node_or_null("Player Center/Bow")
	bow.arrow_damage = damage
	bow.arrow_speed = arrow_speed
	if global_position.y > 1600:  
		get_tree().change_scene_to_file("res://lose_screen.tscn")
	# Animation
	if velocity.x > 1 or velocity.x < -1:
		if Input.is_action_pressed("Run"):
			animated_sprite_2d.animation = "running"
		else:
			animated_sprite_2d.animation = "walking"
	else:
		animated_sprite_2d.animation = "idle"
	
	# Gravity 
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jumping"
		
	# Jump
	if Input.is_action_just_pressed("Jump") and is_on_floor() and not pause_menu.paused:
		velocity.y =JUMP_VELOCITY
		jump_sfx.play(0.0)
		
	# Player direction
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
	#idle
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)
	
	move_and_slide()
	
	# Direction player is facing 
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0:
		animated_sprite_2d.flip_h = true
		
	
func _on_foot_sensor_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		if get_parent().has_method("trigger_block_disappear"):
			get_parent().trigger_block_disappear()


func _on_health_component_health_changed(max: Variant, current: Variant) -> void:
	if current < old_health:
		gold_manager.lose_gold(loss_amount)
	elif current > old_health:
		gold_manager.gain_gold(gain_amount)
	health_bar.value = current
	old_health = current


func _on_health_component_died() -> void:
	_dead()
