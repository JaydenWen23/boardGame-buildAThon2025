# DragDropTextureRect.gd
extends TextureRect

var grid_position = Vector2.ZERO

func _ready():
	# Set grid position from name (cell_0_0, cell_0_1, etc.)
	var name_parts = name.split("_")
	if name_parts.size() >= 3:
		grid_position = Vector2(int(name_parts[1]), int(name_parts[2]))
	else:
		# Fallback: calculate from index
		var index = get_index()
		grid_position = Vector2(index % 4, floor(index / 4))
	
	print("Cell ", name, " at grid position: ", grid_position)

func _get_drag_data(at_position):
	return texture

func _can_drop_data(at_position, data):
	return data is Texture2D

func _drop_data(at_position, data):
	print("Dropping: ", data.resource_path)
	# Use GameManager directly (since it's an autoload)
	if not GameManager.can_place_tower(grid_position):
		print("Cannot place tower here - sphere of influence violation!")
		return
	
	if data.resource_path == 'res://assets/factory1.png' and GameManager.turn == 1 and GameManager.turnz < 31:
		if GameManager.add_tower(grid_position):
			texture = data
			GameManager.turn = 2
			print("Factory placed! Now it's player 2's turn")
			GameManager.turnz -= 1
	elif data.resource_path == 'res://assets/treetower.png' and GameManager.turn == 2 and GameManager.turnz < 31:
		if GameManager.add_tower(grid_position):
			texture = data
			GameManager.turn = 1
			print("Tree tower placed! Now it's player 1's turn")
			GameManager.turnz -= 1
	
	else:
		print("Invalid move - wrong turn or tower type")
