extends Control

@export var hair: TextureRect
@export var eyes: TextureRect
@export var beard: TextureRect
@export var mask: TextureRect
@export var win_text: RichTextLabel
@export var lose_text: RichTextLabel
@export var close_ui_button: Button
@export var culprit_button: Button
@export var reset_timer: Timer

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

func _on_culprit_button_pressed() -> void:
	close_ui_button.disabled = true
	culprit_button.disabled = true
	reset_timer.start()
	if last_npc.culprit:
		win_text.visible = true
	else:
		lose_text.visible = true


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/start.tscn")
