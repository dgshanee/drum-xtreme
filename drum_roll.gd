extends GridContainer


# Called every frame. 'delta' is the elapsed time since the previous frame.

@onready var children = get_children()

@export var bpm: float = 145

var timer
var counter = 0

var beat_counter: Timer
var metronome: AudioStreamPlayer
var kick: AudioStreamPlayer

func _ready():
	# create timers
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 60 / bpm
	timer.connect("timeout", _on_timer_timeout)
	timer.start()

	beat_counter = Timer.new()
	add_child(beat_counter)
	beat_counter.wait_time = 60 / (bpm * 4)
	beat_counter.connect("timeout", _on_bc_timeout)
	beat_counter.start()

	# create metronome
	metronome = AudioStreamPlayer.new()
	metronome.stream = load("res://assets/metronome.wav")
	add_child(metronome)

	# create kick
	kick = AudioStreamPlayer.new()
	kick.stream = load("res://assets/kick.wav")
	add_child(kick)

var encounter = false

func _process(_delta: float):
	children[counter].border_active = true

	if (counter != 0):
		children[counter - 1].border_active = false
	else:
		children[len(children) - 1].border_active = false

	if (children[counter].active and !encounter):
		kick.play()
		encounter = true

func _on_timer_timeout():
	metronome.play()

func _on_bc_timeout():
	counter += 1
	if (counter >= len(children)):
		counter = 0
	encounter = false