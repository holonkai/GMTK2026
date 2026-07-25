extends Node2D




var num_text = preload("res://Scenes/score.tscn")
func _on_area_2d_body_entered(body: Node2D) -> void:
	body.arrow_speed += 100
	#handles the visual stuff
	var text = num_text.instantiate()
	get_tree().current_scene.add_child(text)
	text.text = "Increased Arrow Speed"
	text.global_position = global_position - Vector2(100,100)
	queue_free()
