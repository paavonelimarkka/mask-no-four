extends Control

@export var hair: TextureRect
@export var eyes: TextureRect
@export var beard: TextureRect
@export var mask: TextureRect
var player: Node
var last_npc: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("../Player")
	player.show_ui.connect(_on_show_ui)

func _on_show_ui(npc: NPC):
	last_npc = npc
	hair.texture = npc.hair
	eyes.texture = npc.eyes
	beard.texture = npc.beard
	mask.texture = npc.big_mask
	mask.modulate = npc.custom_modulate
	visible = true

func _on_close_ui_pressed() -> void:
	visible = false
	player.can_move = true
	last_npc.is_moving = true
