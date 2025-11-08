extends Button



func _on_pressed():
	var node = get_node("../Node")  # adjust the path depending on your hierarchy
	for i in node.get_children():
		print(i.name)
		i.texture = load("res://assets/tile.png")
