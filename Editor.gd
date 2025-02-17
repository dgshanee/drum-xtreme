extends GridContainer

const Notch = preload("res://Notch.tscn")


@export var bars: int = 5

@export var resource: Resource

@export var arr: Array

func createNotches():
	arr.clear()
	columns = bars * 4
	for i in bars:
		for j in range(4):
			var notch = Notch.instantiate()
			notch.setup((i + 1) % 2 == 0)
			add_child(notch)
			arr.append(notch)

	print(len(arr))
	

func _ready():
	size.x = 1291
	size.y = 119
	position.x = 115
	# draw notches
	createNotches()

func updateEditorBars(b: int):
	for child in get_children():
		child.queue_free()
	bars = b
	createNotches()
