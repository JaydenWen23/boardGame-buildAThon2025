extends Node

var turn = 1
var tower_positions = []  # [{pos: Vector2, owner: int, type: String}]
var influence_radius = 1

# Resources
var gulden: int = 0
var baume: int = 0  # merged eco stat

func _init():
	print("Starting turn: ", turn)

func can_place_tower(grid_position: Vector2, owner: int) -> bool:
	for tower in tower_positions:
		var distance = abs(tower.pos.x - grid_position.x) + abs(tower.pos.y - grid_position.y)
		# Prevent placing near enemy
		if distance <= influence_radius and tower.owner != owner:
			return false
	return true


func add_tower(grid_position: Vector2, owner: int, tower_type: String) -> bool:
	if not can_place_tower(grid_position, owner):
		print("❌ Cannot place tower at ", grid_position)
		return false

	# Add new tower
	tower_positions.append({
		"pos": grid_position,
		"owner": owner,
		"type": tower_type
	})

	# --- 🌿 CHAIN CHECK LOGIC ---
	var same_adjacent_count = 0
	for tower in tower_positions:
		if tower.owner == owner and tower.type == tower_type:
			var dist = abs(tower.pos.x - grid_position.x) + abs(tower.pos.y - grid_position.y)
			if dist == 1:
				same_adjacent_count += 1

	# --- 🧮 APPLY BONUSES ---
	if tower_type == "factory":
		var base_money = 2
		var chain_bonus_money = same_adjacent_count * 2
		var eco_penalty = same_adjacent_count * 1
		gulden += base_money + chain_bonus_money
		baume -= eco_penalty  # factory pollutes

	elif tower_type == "tree":
		var base_eco = 1
		var chain_bonus_eco = same_adjacent_count * 2
		var money_penalty = same_adjacent_count * 1
		baume += base_eco + chain_bonus_eco
		gulden -= money_penalty
		if gulden < 0:
			gulden = 0
			baume = 0
			get_tree().change_scene_to_file("res://scenes/lost.tscn")  # lose condition

	print("✅ Placed ", tower_type, " at ", grid_position, " (owner ", owner, ")")
	print("   Adjacent same-type towers: ", same_adjacent_count)
	print("   Gulden: ", gulden, " | Baume: ", baume)

	return true
