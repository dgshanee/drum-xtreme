extends Panel

@export var border_active: bool = false

@export var active: bool = false

@onready var color_rect: ColorRect = $ColorRect

@export var border: ColorRect

func _process(delta: float):
    border.visible = border_active
    active = color_rect.active