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
@export var huhs: Array[AudioStreamOggVorbis]
@export var huh_player: AudioStreamPlayer
@export var win_player: AudioStreamPlayer
@export var lose_player: AudioStreamPlayer


signal stop_timer()

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
	huh_player.stream = huhs[randi_range(0, huhs.size() - 1)]
	huh_player.play()
	

func _on_close_ui_pressed() -> void:
	visible = false
	player.can_move = true
	last_npc.start_moving_timer.start()

func _on_culprit_button_pressed() -> void:
	close_ui_button.disabled = true
	culprit_button.disabled = true
	reset_timer.start()
	stop_timer.emit()
	if last_npc.culprit:
		win_text.visible = true
		win_player.play()
	else:
		lose_text.visible = true
		lose_player.play()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/start.tscn")
