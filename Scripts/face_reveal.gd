extends Control

@export var npc_generator: Node
@export var hair: TextureRect
@export var eyes: TextureRect
@export var beard: TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _on_npc_generator_draw_culprit(npc: Variant) -> void:
	hair.texture = npc.hair
	eyes.texture = npc.eyes
	beard.texture = npc.beard
