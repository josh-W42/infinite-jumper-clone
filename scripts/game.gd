extends Node2D

@onready var camera: Game_Camera = $GameCamera
@onready var player: Player = $Player

func _ready() -> void:
	camera._setup_camera(player)
