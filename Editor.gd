extends GridContainer

const Notch = preload("res://Notch.tscn")

@export var bars: int = 4

@export var resource: Resource

@export var arr: Array

func _ready():
	# draw notches
	columns = bars * 4
	for i in bars:
		for j in range(4):
			var notch = Notch.instantiate()
			notch.setup((i + 1) % 2 == 0)
			add_child(notch)
			arr.append(notch)
