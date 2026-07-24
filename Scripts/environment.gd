extends Node2D

@onready var layers: Array[TileMapLayer] = [$LayerA, $LayerB, $LayerC]
@onready var timer: Timer = $DisappearTimer
@onready var countdown: Label = $countdown

var current_index: int = 1
var is_timer_active: bool = false

func _ready() -> void:
	# Show initial active layer
	_update_active_layer()
	timer.timeout.connect(_on_timer_timeout)
	trigger_block_disappear()

# Countdown display
func _process(_delta: float) -> void:
	print("is_timer_active=", is_timer_active, " stopped=", timer.is_stopped())
	if not timer.is_stopped():
		countdown.text = "The Footholds will switch in %.1f" % timer.time_left
	else:
		countdown.text = ""

func trigger_block_disappear() -> void:
	if not is_timer_active:
		is_timer_active = true
		timer.start(10.0)

func _on_timer_timeout() -> void:
	current_index = (current_index + 1) % layers.size()
	print(current_index)
	# Want to update the layer mask first maybe an animation
	_update_active_layer()
	timer.start(10.0)

func _update_active_layer() -> void:
	for i in range(layers.size()):
		var layer = layers[i]
		var is_current = (i == current_index)
		
		# Set the new layer to visible
		layer.visible = is_current
		layer.collision_enabled = is_current

		layer.set_process_mode(
			PROCESS_MODE_INHERIT if is_current else PROCESS_MODE_DISABLED
		)
