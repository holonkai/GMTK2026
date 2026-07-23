extends Control

@onready var pause_menu: Control = $"."
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var paused := false

func _process(delta: float) -> void:
		if Input.is_action_just_pressed("pause"):
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
	Engine.time_scale = 1
	paused = false
	animation_player.play("Fade Out")
	pause_menu.hide()


func _on_title_pressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	

func _on_restart_pressed() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Fade In":
		Engine.time_scale = 0
	elif anim_name == "Fade Out":
		Engine.time_scale = 1
	
