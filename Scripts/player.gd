extends CharacterBody2D

signal show_ui(npc)

const SPEED = 400.0

var nearby_npcs: Array = []

func _ready() -> void:
	$InteractArea.body_entered.connect(_on_interact_area_body_entered)
	$InteractArea.body_exited.connect(_on_interact_area_body_exited)

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("npc"):
		nearby_npcs.append(body)

func _on_interact_area_body_exited(body: Node2D) -> void:
	nearby_npcs.erase(body)

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * SPEED

func _physics_process(delta):
	get_input()
	move_and_slide()

func _process(delta):
	if Input.is_action_just_pressed("Interact") and nearby_npcs.size() > 0:
		print("painoin ja olis zonellaki")
		var npc = nearby_npcs[0]
		npc.stop_movement()
		emit_signal("show_ui", npc)
