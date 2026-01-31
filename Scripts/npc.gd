extends CharacterBody2D

const SPEED = 300.0

var direction: Vector2
var is_moving: bool = false

func _ready() -> void:
	direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	velocity = direction * SPEED
	is_moving = true

func _physics_process(delta: float) -> void:
	if (is_moving == true):
		move_and_slide()

	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		# Reflect velocity based on collision normal
		velocity = velocity.bounce(collision.get_normal()).normalized() * SPEED

func stop_movement() -> void:
	print("pysähyppäs")
	is_moving = false
