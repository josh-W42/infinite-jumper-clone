extends Node2D

@onready var camera: Game_Camera = $GameCamera
@onready var player: Player = $Player
@onready var level_gen: LevelGenerator = $LevelGenerator 

func _ready() -> void:
	camera._setup_camera(player)
	level_gen.start(player)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
