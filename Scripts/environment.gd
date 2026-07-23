extends Node2D

@onready var layers: Array[TileMapLayer] = [$LayerA, $LayerB, $LayerC]
@onready var timer: Timer = $DisappearTimer

var current_index: int = 1
var is_timer_active: bool = false

func _ready() -> void:
	# Show initial active layer
	_update_active_layer()
	timer.timeout.connect(_on_timer_timeout)

func trigger_block_disappear() -> void:
	if not is_timer_active:
		is_timer_active = true
		timer.start(5.0)

func _on_timer_timeout() -> void:
	current_index = (current_index + 1) % layers.size()
	print(current_index)
	# Want to update the layer mask first maybe an animation
	_update_active_layer()
	timer.start(5.0)

func _update_active_layer() -> void:
	for i in range(layers.size()):
		var layer = layers[i]
		var is_current = (i == current_index)
		
		#set the new layer to visible
		layer.visible = is_current
		layer.collision_enabled = is_current

		layer.set_process_mode(
			PROCESS_MODE_INHERIT if is_current else PROCESS_MODE_DISABLED
		)
