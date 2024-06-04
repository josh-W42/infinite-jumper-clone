class_name Game_Camera

extends Camera2D

var player: Player

func _ready() -> void:
	global_position.x = get_viewport_rect().size.x / 2
	
func _physics_process(delta: float) -> void:
	if player != null:
		global_position.y = player.global_position.y
	
func _setup_camera(_player: Player) -> void:
	if _player != null:
		player = _player
