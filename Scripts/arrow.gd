extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var speed := 600.0
@export var gravity := 50.0
@export var damage := 50.0

var velocity := Vector2.ZERO

func _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	
	rotation = velocity.angle()
	print(rotation)


func set_direction(dir: Vector2):
	velocity = dir.normalized() * speed


func _on_area_2d_body_entered(body: Node2D):
	print("im hitting something")

	var health_component = body.get_node_or_null("HealthComponent")
	if health_component:
		health_component.take_damage(damage)

	queue_free()
