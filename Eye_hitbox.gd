extends Area2D


@export var damage := 5.0

var knock_back_dir := Vector2.ZERO
var player:= Vector2.ZERO

func _on_body_entered(body: Node2D) -> void:
	var health_component = body.get_node_or_null("HealthComponent")
	if health_component == null:
		return
	health_component.take_damage(damage)
