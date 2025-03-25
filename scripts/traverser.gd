extends Control

@onready var traverser_container: HBoxContainer = $traverser_container

func updateTraverserBars(b: int):
    traverser_container.bars = b
    traverser_container.createNotches()
