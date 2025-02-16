extends Panel

@export var kick_editor: GridContainer
@export var snare_editor: GridContainer

@export var BPM = 140

var timer: Timer

var metronome: AudioStreamPlayer
var metronome_time: float = 0.0

var kick: AudioStreamPlayer
var snare: AudioStreamPlayer

func _ready():
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

    # init kick
    kick = AudioStreamPlayer.new()
    add_child(kick)
    kick.stream = kick_editor.resource

    #init snare
    snare = AudioStreamPlayer.new()
    add_child(snare)
    snare.stream = snare_editor.resource


func _on_timer_timeout():
    if (kick_editor.arr[metronome_time].active):
        kick.play()

    if (snare_editor.arr[metronome_time].active):
        snare.play()
    metronome_time += 1
    if (metronome_time >= kick_editor.bars * 4):
        metronome_time = 0
    if (fmod(metronome_time, 4) == 1.0):
        metronome.play()