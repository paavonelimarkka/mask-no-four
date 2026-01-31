extends CharacterBody2D

const SPEED = 300.0

var direction: Vector2

func _ready() -> void:
	direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	velocity = direction * SPEED

func _physics_process(delta: float) -> void:
	move_and_slide()

	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		# Reflect velocity based on collision normal
		velocity = velocity.bounce(collision.get_normal()).normalized() * SPEED
