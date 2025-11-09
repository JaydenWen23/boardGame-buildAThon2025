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

	var tower_type = ""
	if data.resource_path == "res://assets/factory1.png":
		tower_type = "factory"
	elif data.resource_path == "res://assets/treetower.png":
		tower_type = "tree"

	if tower_type == "":
		print("Unknown tower type")
		return

	# FIXED: add owner parameter
	if not GameManager.can_place_tower(grid_position, GameManager.turn):
		print("Cannot place tower here - sphere of influence violation!")
		return

	if GameManager.turn == 1 and tower_type == "factory" and GameManager.baume <= 10:
		if GameManager.add_tower(grid_position, 1, tower_type):
			texture = data
			GameManager.turn = 2
			if GameManager.gulden >= 10:
				GameManager.gulden = 0
				GameManager.baume = 0
				get_tree().change_scene_to_file("res://scenes/WIN.tscn")
			print("Factory placed! Now it's player 2's turn")

	elif GameManager.turn == 2 and tower_type == "tree" and GameManager.gulden <= 10:
		if GameManager.add_tower(grid_position, 2, tower_type):
			texture = data
			GameManager.turn = 1
			if GameManager.baume >= 10:
				GameManager.gulden = 0
				GameManager.baume = 0
				get_tree().change_scene_to_file("res://scenes/lost.tscn")
			print("Tree tower placed! Now it's player 1's turn")
	else:
		print("Invalid move - wrong turn or tower type")


	
