extends Node2D

@export var max_npcs: int
@export var npc_scene: PackedScene
var npc_array: Array[NPC]
var unique_ids: Array[String]
@export var hairs: Array[CompressedTexture2D]
@export var eyes: Array[CompressedTexture2D]
@export var beards: Array[CompressedTexture2D]
@export var big_masks: Array[CompressedTexture2D]
@export var small_masks: Array[CompressedTexture2D]

signal draw_culprit(npc)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in max_npcs:
		var npc = npc_scene.instantiate()
		var id: String
		var hair: int
		var eye: int
		var beard: int
		var mask = randi_range(0, big_masks.size() - 1)
		npc.big_mask = big_masks[mask]
		npc.small_mask = small_masks[mask]
		npc.custom_modulate = Color(1, randf(), randf(), 1.0)
		
		while true:
			hair = randi_range(0, hairs.size() - 1)
			eye = randi_range(0, eyes.size() - 1)
			beard = randi_range(0, beards.size() - 1)
			id = str(hair) + str(eye) + str(beard)
			
			if id not in unique_ids:
				unique_ids.append(id)
				npc.identifier = id
				npc.hair = hairs[hair]
				npc.eyes = eyes[eye]
				npc.beard = beards[beard]
				break
		
		npc_array.append(npc)
	
	var culprit_id = randi_range(0, npc_array.size() -1)
	npc_array[culprit_id].culprit = true
	emit_signal("draw_culprit", npc_array[culprit_id])
	
	for i in npc_array.size():
		var angle := TAU * i / npc_array.size()
		var pos := Vector2(cos(angle), sin(angle)) * 200
		get_parent().find_child("NPCs").add_child(npc_array[i])
		npc_array[i].position = pos
