extends Node

@onready var timer: Timer = $Timer
@onready var timer_text: RichTextLabel = $Control/TimerText

func _ready():
	timer.start()

func _process(delta):
	timer_text.text = "%s" % int(timer.time_left)
