# GameManager.gd (attach to a root node)
extends Node

var turn = int(randf_range(1, 2))
var tower_positions = []  # Store positions of placed towers
var influence_radius = 2  # Cells radius for sphere of influence
var turnz = 30
var towersF: int = 0
var towersP: int = 0
func _init():
	print("Starting turn: ", turn)

func can_place_tower(grid_position):
	for tower_pos in tower_positions:
		# Calculate Manhattan distance (or Euclidean if you prefer)
		var distance = abs(tower_pos.x - grid_position.x) + abs(tower_pos.y - grid_position.y)
		if distance <= influence_radius:
			return false
	return true

func add_tower(grid_position):
	if can_place_tower(grid_position):
		tower_positions.append(grid_position)
		return true
	return false
