extends Node2D

@onready var level_gen: LevelGenerator = $LevelGenerator 
@onready var ground_sprite: Sprite2D = $Ground

@onready var parallax1 = $ParallaxBackground/ParallaxLayer
@onready var parallax2 = $ParallaxBackground/ParallaxLayer2
@onready var parallax3 = $ParallaxBackground/ParallaxLayer3

var camera_scene = preload("res://scenes/game_camera.tscn")
var player_scene = preload("res://scenes/player.tscn")
var player: Player

var player_spawn_position: Vector2
var viewport_size: Vector2

# Comments on paralax layer settings
# 
# 1: We want the layers to mirror properly without
# having the textures be uneven.
# - Things to remember, the height of the paralax texture and it's scale are
# related in order to have even mirroring
#
#
# 2: We need the paralax background to be dynamicly sized to the viewport
# to handle varying viewport sizes encountered on mobile.

func _ready() -> void:
	viewport_size = get_viewport_rect().size
	
	var player_spawn_pos_y_offset = 135
	player_spawn_position.x = viewport_size.x / 2.0
	player_spawn_position.y = viewport_size.y - player_spawn_pos_y_offset
	
	
	ground_sprite.global_position.x = viewport_size.x / 2.0
	ground_sprite.global_position.y = viewport_size.y
	
	setup_parallax_layer(parallax1)
	setup_parallax_layer(parallax2)
	setup_parallax_layer(parallax3)
	
	new_game()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
func new_game() -> void:
	player = player_scene.instantiate()
	player.global_position = player_spawn_position
	add_child(player)
	
	var camera = camera_scene.instantiate()
	camera._setup_camera(player)
	add_child(camera)
		
	level_gen.start(player)
	
func setup_parallax_layer(layer: ParallaxLayer):
	var sprite = layer.find_child("Sprite2D")
	if sprite != null:
		sprite.scale = get_parallax_spite_scale(sprite)
		var delta_y = sprite.scale.y * sprite.get_texture().get_height()
		layer.motion_mirroring.y = delta_y
	 
func get_parallax_spite_scale(sprite: Sprite2D) -> Vector2:
	var texture = sprite.get_texture()
	var texture_width = texture.get_width()
	
	var sprite_scale = viewport_size.x / texture_width
	var result = Vector2(sprite_scale, sprite_scale)
	return result
	
	
