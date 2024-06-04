class_name Game_Camera

extends Camera2D

@onready var destroyer: Area2D = $Destroyer
@onready var destroyer_collision: CollisionShape2D = $Destroyer/CollisionShape2D

var player: Player
var viewport_size: Vector2;

func _ready() -> void:
	viewport_size = get_viewport_rect().size
	global_position.x = viewport_size.x / 2
	
	limit_bottom = viewport_size.y
	limit_left = 0
	limit_right = viewport_size.x
	
	position_destroyer()
	
func _process(delta: float) -> void:
	if player:
		var limit_offset = 420
		if limit_bottom > player.global_position.y + limit_offset:
			limit_bottom = player.global_position.y + limit_offset
	
	var overlapping_areas = destroyer.get_overlapping_areas()
	for area in overlapping_areas:
		if area is Platform:
			area.queue_free()
	
func _physics_process(delta: float) -> void:
	if player != null:
		global_position.y = player.global_position.y
	
func _setup_camera(_player: Player) -> void:
	if _player != null:
		player = _player
		
func position_destroyer() -> void:
	destroyer.position.y = viewport_size.y / 2
	
	var rect_shape: RectangleShape2D = RectangleShape2D.new()
	var rect_shape_size: Vector2 = Vector2(viewport_size.x, 200)
	rect_shape.set_size(rect_shape_size)
	destroyer_collision.shape = rect_shape

