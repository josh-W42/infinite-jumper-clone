class_name Game_Camera

extends Camera2D

var player: Player
var viewport_size: Vector2;

func _ready() -> void:
	viewport_size = get_viewport_rect().size
	global_position.x = viewport_size.x / 2
	
	limit_bottom = viewport_size.y
	limit_left = 0
	limit_right = viewport_size.x
	
func _process(delta: float) -> void:
	if player:
		var limit_offset = 420
		if limit_bottom > player.global_position.y + limit_offset:
			limit_bottom = player.global_position.y + limit_offset
	
func _physics_process(delta: float) -> void:
	if player != null:
		global_position.y = player.global_position.y
	
func _setup_camera(_player: Player) -> void:
	if _player != null:
		player = _player
