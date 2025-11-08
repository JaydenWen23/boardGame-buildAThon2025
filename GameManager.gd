# GameManager.gd
extends Node

var turn = int(randf_range(1, 2))
var tower_positions = []
var influence_radius = 1.5  # Use 1.5 to include diagonals but not skip cells
var grid_size = 4

func _init():
	print("Starting turn: ", turn)

func can_place_tower(grid_position):
	# Check grid bounds
	if grid_position.x < 0 or grid_position.x >= grid_size or grid_position.y < 0 or grid_position.y >= grid_size:
		return false

	# Check if already occupied
	if grid_position in tower_positions:
		return false

	# Prevent adjacency (including diagonals)
	for tower_pos in tower_positions:
		var dx = abs(tower_pos.x - grid_position.x)
		var dy = abs(tower_pos.y - grid_position.y)
		if dx <= 1 and dy <= 1:  # 8-direction adjacency block
			return false

	return true


func add_tower(grid_position):
	if can_place_tower(grid_position):
		tower_positions.append(grid_position)
		print("Tower placed at: ", grid_position)
		print("All tower positions: ", tower_positions)
		return true
	return false
