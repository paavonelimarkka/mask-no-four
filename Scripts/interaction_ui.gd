extends Control

@export var hair: TextureRect
@export var eyes: TextureRect
@export var beard: TextureRect
@export var mask: TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = get_node("../Player")
	player.show_ui.connect(_on_show_ui)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_show_ui(npc: NPC):
	hair.texture = npc.hair
	eyes.texture = npc.eyes
	beard.texture = npc.beard
	mask.texture = npc.big_mask
	mask.modulate = npc.custom_modulate
	visible = true

func _on_close_ui_pressed() -> void:
	visible = false
