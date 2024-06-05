class_name LevelGenerator

extends Node2D

@onready var platform_parent: Node2D = $PlatfomParent

var platform_scene = preload("res://scenes/platform.tscn")

var viewport_size: Vector2
var platform_width: int = 140
var start_platform_y
var y_distance_between_platforms = 100
var level_size = 10
var generated_platform_count = 0
var player: Player
	
func start(_player: Player) -> void:
	player = _player
	viewport_size = get_viewport_rect().size
	start_platform_y = viewport_size.y - (y_distance_between_platforms * 2)
	generate_level(start_platform_y, true)

func _process(_delta: float) -> void:
	if player:
		var py = player.global_position.y
		var end_of_level_y_position = start_platform_y - (generated_platform_count *  y_distance_between_platforms)
		var threshold = end_of_level_y_position - player.position.y
		if  py <= threshold:
			generate_level(end_of_level_y_position, false)


func generate_ground() -> void:
	var platform_count = ceil(viewport_size.x / platform_width) + 1
	var platform_vertical_offset = 50
	
	for i in range(platform_count):
		create_platform(Vector2(platform_width * i, viewport_size.y - platform_vertical_offset))

func generate_level(start_y: float, should_generate_ground: bool) -> void:
	if should_generate_ground:
		generate_ground()
		
	for i in range(level_size):
		var max_x_position = viewport_size.x - platform_width
		var random_x = randf_range(0, max_x_position)
		
		var location: Vector2 = Vector2(random_x, start_y - y_distance_between_platforms * i)
		
		create_platform(location)
		generated_platform_count += 1

func create_platform(location: Vector2) -> Platform:
	var instance = platform_scene.instantiate()
	instance.global_position = location
	platform_parent.add_child(instance)
	return instance
