extends Panel

@onready var header: GridContainer = $Header

@export var play_button: TextureRect

class editor_obj:
	var editor: GridContainer
	var editor_stream: AudioStreamPlayer

	func _init(e: GridContainer, s: AudioStreamPlayer):
		editor = e
		editor_stream = s

@export var kick_editor: GridContainer
@export var snare_editor: GridContainer
@export var hh_editor: GridContainer
@export var crash_editor: GridContainer

@export var paused: bool = false

var editors: Array

var editor_objs: Array

@export var BPM = 140

var timer: Timer

var metronome: AudioStreamPlayer
var metronome_time: float = 0.0
var metronome_on: bool = false

var kick: AudioStreamPlayer
var snare: AudioStreamPlayer

func _process(delta: float):
	metronome_on = header.metronome_on
	if (paused and !timer.is_stopped()):
		timer.stop()
		metronome_time = 0
	if (!paused and timer.is_stopped()):
		timer.start()
		metronome_time = 0

func _ready():
	editors = [kick_editor, snare_editor, hh_editor, crash_editor]

	# connect to header
	header.connect("bars_was_changed", updateBars)
	header.connect("bpm_was_changed", updateBPM)
	# make timer
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 60 / float(BPM * 4)
	timer.connect("timeout", _on_timer_timeout)
	timer.start()

	# make metronome
	metronome = AudioStreamPlayer.new()
	add_child(metronome)
	metronome.stream = load("res://assets/metronome.wav")

	for i in range(len(editors)):
		var stream: AudioStreamPlayer = AudioStreamPlayer.new()
		add_child(stream)
		stream.stream = editors[i].resource
		var obj = editor_obj.new(editors[i], stream)
		editor_objs.append(obj)

	play_button.connect("gui_input", handle_pause_play)

func handle_pause_play(event: InputEvent):
	if event is InputEventMouseButton:
		if (!event.pressed):
			if (paused):
				play_button.texture = load("res://assets/pause.png")
			else:
				play_button.texture = load("res://assets/play.png")

			paused = !paused


func _on_timer_timeout():
	metronome_time = fmod(metronome_time, len(kick_editor.arr))
	if (len(kick_editor.arr) > 20):
		print(metronome_time)
		print(kick_editor.arr[metronome_time].active)
	if (len(kick_editor.arr) > 0):
		# if (kick_editor.arr[metronome_time].active):
		# 	kick.play()
		# if (snare_editor.arr[metronome_time].active):
		# 	snare.play()

		# for editor in editor_objs:
		# 	if (editor.arr[metronome_time].active):
		# 		editor.play()

		for obj in editor_objs:
			if (obj.editor.arr[metronome_time].active):
				print("playing")
				obj.editor_stream.play()

	metronome_time += 1
	if (fmod(metronome_time, 4) == 1.0) and metronome_on:
		metronome.play()

func updateBars(bars_input: int):
	metronome_time = 0
	for editor in editors:
		editor.updateEditorBars(bars_input)

func updateBPM(b: int):
	BPM = b
	timer.wait_time = 60 / float(BPM * 4)
