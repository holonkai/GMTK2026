extends Node2D

var num_text = preload("res://Scenes/score.tscn")
func _on_area_2d_body_entered(body: Node2D) -> void:
	body.damage += 20
	#handles the visual stuff
	var text = num_text.instantiate()
	get_tree().current_scene.add_child(text)
	text.text = "Increased Damage"
	text.global_position = global_position - Vector2(100,100)
	queue_free()
