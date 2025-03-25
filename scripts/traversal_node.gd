extends Panel

@export var active: bool = false

@onready var colorNode: ColorRect = $node_color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if (active):
        colorNode.visible = true
    else:
        colorNode.visible = false
