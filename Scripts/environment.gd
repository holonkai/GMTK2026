extends Node2D

@onready var layers: Array[TileMapLayer] = [$LayerA, $LayerB, $LayerC]
@onready var timer: Timer = $DisappearTimer

var current_index: int = 0
var is_timer_active: bool = false

func _ready() -> void:
	# Show initial active layer
	_update_active_layer()
	timer.timeout.connect(_on_timer_timeout)

func trigger_block_disappear() -> void:
	if not is_timer_active:
		is_timer_active = true
	

func _on_timer_timeout() -> void:
	current_index = (current_index + 1) % layers.size()
	#want to update the layer mask first maybe an animation
	_update_active_layer()
	
	timer.start(3.0) # Timer

func _update_active_layer() -> void:
	for i in range(layers.size()):
		var layer = layers[i]
		var is_current = (i == current_index)
		
		#set the new layer to visible
		layer.visible = is_current
		
		layer.set_process_mode(
			PROCESS_MODE_INHERIT if is_current else PROCESS_MODE_DISABLED
		)
