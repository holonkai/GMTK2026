extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sfx: AudioStreamPlayer2D = $"../JumpSFX"


const SPEED = 300.0
const JUMP_VELOCITY = -850.0

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
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y =JUMP_VELOCITY
		jump_sfx.play(0.0)
		
	# Player direction
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	# Direction player is faceing 
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0:
		animated_sprite_2d.flip_h = true
		
	
