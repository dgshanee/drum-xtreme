extends GridContainer

@export var bpm: int = 140
@export var bars: int = 4

@export var bpm_input: LineEdit
@export var bars_input: LineEdit

@onready var metronome_toggle: Button = $metronome_container/metronome_toggle
@export var metronome_on: bool = false

signal bpm_was_changed(bpm)
signal bars_was_changed(bars)

func _ready():
    bpm_input.connect("text_submitted", updateBPM)
    bars_input.connect("text_submitted", updateBars)
    metronome_toggle.connect("pressed", toggle_metronome)

func toggle_metronome():
    metronome_on = metronome_toggle.button_pressed

func updateBPM(new_text: String):
    if (new_text.is_valid_int()):
        bpm = int(new_text)
        print(bpm)
        emit_signal("bpm_was_changed", bpm)

func updateBars(new_text: String):
    print("hello")
    if (new_text.is_valid_int):
        bars = int(new_text)
        emit_signal("bars_was_changed", bars)