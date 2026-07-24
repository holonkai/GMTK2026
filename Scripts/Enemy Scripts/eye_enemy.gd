extends CharacterBody2D

@export var movement_component : MovementComponent
@export var health_component : HealthComponent
@export var stats: EnemyStats
@onready var hitbox: Area2D = $Hitbox
@onready var hurtbox: CollisionShape2D = $Hurtbox
@onready var health_bar: ProgressBar = $HealthBar
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var gold_give: int
func _ready() -> void:
	health_component.max_health = stats.health
	health_component.current_health = health_component.max_health
	movement_component.speed = stats.speed
	health_bar.max_value = health_component.max_health
	gold_give = stats.gold_drop

func _process(delta: float) -> void:
	health_bar.value = health_component.current_health
	if movement_component.dir.length() < 300:
		movement_component.get_recent_position()
	else:
		movement_component.chasing = true
	


func _on_health_component_died() -> void:
	velocity = Vector2.ZERO
	movement_component.can_move = false
	hitbox.queue_free()
	hurtbox.queue_free()
	animated_sprite_2d.play("Death")
	
	


func _on_animated_sprite_2d_animation_finished() -> void:
	get_tree().get_first_node_in_group("Player").get_node_or_null("GoldManager").gain_gold(gold_give)
	queue_free()
