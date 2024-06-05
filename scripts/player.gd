class_name Player

extends CharacterBody2D

@onready var animator = $AnimationPlayer

var speed: int = 500
var gravity: int = 15
var max_fall_velocity: int = 1000
var jump_velocity = -800

var viewport_rect: Vector2

func _ready() -> void:
	viewport_rect = get_viewport_rect().size
	
	
func _process(_delta: float) -> void:
	if velocity.y > 0 && animator.current_animation != "Fall":
		animator.play("Fall")
	elif velocity.y < 0 && animator.current_animation != "Jump":
		animator.play("Jump")


func _physics_process(delta: float) -> void:
	velocity.y += gravity
	if velocity.y > max_fall_velocity:
		velocity.y = max_fall_velocity

	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x += speed * direction * delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		
	move_and_slide()
	
	var margin = 30
	if global_position.x > viewport_rect.x + margin:
		global_position.x = -margin
	elif global_position.x <= -margin:
		global_position.x = viewport_rect.x + margin
	 
func jump() -> void:
	velocity.y = jump_velocity
	
