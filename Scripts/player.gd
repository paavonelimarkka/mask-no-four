extends CharacterBody2D

signal show_ui(npc)

const SPEED = 400.0

var nearby_npcs: Array = []
var can_move: bool = false

func _ready() -> void:
	can_move = true
	$InteractArea.body_entered.connect(_on_interact_area_body_entered)
	$InteractArea.body_exited.connect(_on_interact_area_body_exited)

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("npc"):
		nearby_npcs.append(body)
	if body.is_in_group("poster"):
		print("osuin posteriin triggaa joku lärvi")

func _on_interact_area_body_exited(body: Node2D) -> void:
	nearby_npcs.erase(body)
	if body.is_in_group("poster"):
		print ("lähdin pois lärvi pois")

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * SPEED

func _physics_process(delta):
	if(can_move == true):
		get_input()
		move_and_slide()

func _process(delta):
	print(nearby_npcs.size())
	if Input.is_action_just_pressed("Interact") and nearby_npcs.size() > 0:
		var npc = nearby_npcs[0]
		npc.stop_movement()
		emit_signal("show_ui", npc)
		can_move = false
