extends HBoxContainer

@export var bars: int = 4
@export var arr: Array

const TraversalNode = preload("res://scenes/traversal_node.tscn")

func createNotches():
	for child in get_children():
		child.queue_free()
	arr.clear()
	var columns := bars * 4

	for i in columns:
		var panel: Node = TraversalNode.instantiate()
		panel.custom_minimum_size.x = 146
		add_child(panel)
		arr.append(panel)

func _ready():
	createNotches()
