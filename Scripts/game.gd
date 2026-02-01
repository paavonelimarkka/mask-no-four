extends Node2D

@export var SFXStreams: Array[AudioStreamOggVorbis]
@export var SFXPlayers: Array[AudioStreamPlayer2D]
@export var mumbling_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	print("aikaloppu")
	get_tree().change_scene_to_file("res://Scenes/start.tscn")


func _on_mumbling_timer_timeout() -> void:
	print("Maybe play")
	if randi_range(0, 3) >= 1:
		print("Lets play")
		mumbling_timer.stop()
		var sfx_player = SFXPlayers[randi_range(0, SFXPlayers.size() - 1)]
		sfx_player.stream = SFXStreams[randi_range(0, SFXStreams.size() - 1)]
		sfx_player.play()


func _on_sfx_finished() -> void:
	mumbling_timer.start()
