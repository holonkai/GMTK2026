extends Control

@onready var pause_menu: Control = $"."
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var paused := false

func _process(delta: float) -> void:
		if Input.is_action_just_pressed("pause"):
			print("work")
			if not paused:
				pause()
			else:
				resume()

func pause() -> void:
	paused = true
	animation_player.play("Fade In")
	pause_menu.show()
	

func _on_resume_pressed() -> void:
	resume()

func resume() -> void:
	paused = false
	animation_player.play("Fade Out")
	pause_menu.hide()


func _on_title_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
