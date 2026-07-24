extends Node2D

var speed := 100
var direction := Vector2.ZERO
# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_hitbox_body_entered(body: Node2D) -> void:
	queue_free()
