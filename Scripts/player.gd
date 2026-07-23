extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sfx: AudioStreamPlayer2D = $"../JumpSFX"
@onready var pause_menu: Control = $PauseMenu


const SPEED := 300.0
const FRICTION := 1200.0
const ACCELERATION := 800.0
const JUMP_VELOCITY := -1500.0

func _ready() -> void:
	pause_menu.hide()
	
	
func _physics_process(delta: float) -> void:
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
	# Check if the body we touched is a TileMapLayer (the ground)
	if body is TileMapLayer:
		# Find the main scene manager and tell it to start the timer
		# (Replace 'get_parent()' with your scene manager path if needed)
		if get_parent().has_method("trigger_block_disappear"):
			get_parent().trigger_block_disappear()
