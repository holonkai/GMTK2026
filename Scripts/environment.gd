extends Node2D

@onready var layers: Array[TileMapLayer] = [$LayerA, $LayerB, $LayerC]
@onready var timer: Timer = $DisappearTimer
@onready var countdown: Label = $countdown

var current_index: int = 1
var is_timer_active: bool = false
var fade_duration: float = 0.6 

func _ready() -> void:
	# Fading effect
	for layer in layers:
		layer.modulate.a = 0.0
		layer.visible = false
		layer.collision_enabled = false
	# Show initial active layer
	_update_active_layer()
	timer.timeout.connect(_on_timer_timeout)
	trigger_block_disappear()

# Countdown display
func _process(_delta: float) -> void:
	if not timer.is_stopped():
		pass
		countdown.text = "The Footholds will switch in %.1f" % timer.time_left
	else:
		pass
		countdown.text = ""
		
func trigger_block_disappear() -> void:
	if not is_timer_active:
		is_timer_active = true
		timer.start(10.0)

func _on_timer_timeout() -> void:
	var previous_index := current_index
	current_index = (current_index + 1) % layers.size()
	_switch_layer(previous_index, current_index)
	timer.start(10.0)

func _update_active_layer() -> void:
	for i in range(layers.size()):
		var is_current := (i == current_index)
		layers[i].visible = is_current
		layers[i].modulate.a = 1.0 if is_current else 0.0
		layers[i].collision_enabled = is_current

func _switch_layer(from_index: int, to_index: int) -> void:
	var old_layer := layers[from_index]
	var new_layer := layers[to_index]

	new_layer.visible = true
	new_layer.modulate.a = 0.0
	new_layer.collision_enabled = true  # see note below

	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(old_layer, "modulate:a", 0.0, fade_duration)
	tween.tween_property(new_layer, "modulate:a", 1.0, fade_duration)

	tween.chain().tween_callback(func():
		old_layer.visible = false
		old_layer.collision_enabled = false
	)
