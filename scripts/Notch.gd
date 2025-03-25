extends Panel

@export var active: bool = false

@onready var color: ColorRect = $color

var even: bool

func setup(even_bar: bool):
	even = even_bar

func _ready():
	if (even):
		color.color = Color.CORAL
	color.connect("gui_input", _on_gui_input)

func _process(_delta: float):
	if (active):
		color.color = Color.YELLOW
	else:
		color.color = Color.CORAL if even else Color.WHITE

	
func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if !event.pressed:
			active = !active