class_name NPC extends CharacterBody2D

@export var speed = 100.0

@export var animation_player: AnimationPlayer
@export var sprites: Node2D
var direction: Vector2
var is_moving: bool = false
var identifier: String
var hair: CompressedTexture2D
var eyes: CompressedTexture2D
var beard: CompressedTexture2D
var big_mask: CompressedTexture2D
var small_mask: CompressedTexture2D
var custom_modulate: Color
var culprit = false
@export var start_moving_timer: Timer
@export var jiggle_start_timer: Timer

func _ready() -> void:
	direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	velocity = direction * speed
	is_moving = true
	$Sprites/Body.modulate = Color(1, randf(), randf(), 1.0)
	
	var sprite := Sprite2D.new()
	sprite.texture = small_mask
	sprite.position = Vector2(0,-10)
	sprite.scale = Vector2(2, 2)
	sprite.modulate = custom_modulate
	sprites.add_child(sprite)
	animation_player.current_animation = "jiggle"

func _physics_process(delta: float) -> void:
	if (is_moving == true):
		move_and_slide()

	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		# Reflect velocity based on collision normal
		velocity = velocity.bounce(collision.get_normal()).normalized() * speed

func stop_movement() -> void:
	is_moving = false


func _on_start_moving_timeout() -> void:
	is_moving = true


func _on_jiggle_start_timer_timeout() -> void:
	print("Start jiggling")
	animation_player.active = true
