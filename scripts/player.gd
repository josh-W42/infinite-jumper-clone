extends CharacterBody2D

var speed: int = 500
var gravity: int = 15
var max_fall_velocity: int = 1000

var viewport_rect: Vector2

func _ready() -> void:
	viewport_rect = get_viewport_rect().size
	
	
func _process(delta: float) -> void:
	pass


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
	 
	
