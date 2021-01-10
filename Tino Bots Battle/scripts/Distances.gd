extends Node
class_name Distance

const empty_map = [
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

var elevation_map = empty_map.duplicate(true)
var forest_map = empty_map.duplicate(true)
var water_map = empty_map.duplicate(true)

var current_tile = Vector2(0, 0)  # index of current node
var unvisited_tiles = []
var distances = empty_map.duplicate(true)

func _init(origin, level_elevation_map=[], level_forest_map=[], level_water_map=[], elevation_sensitive = true, forest_sensitive = true, water_sensitive = true):
	current_tile = origin
	# set all distances to 9999 and unvisited tiles to all tiles possible 
	for i in range(10):
		for j in range(10):
			distances[i][j] = 9999
			unvisited_tiles.append(Vector2(i,j))
	# execpt dist in current tile = 0
	distances[current_tile.x][current_tile.y] = 0
	
	# create empty arrays if params are missing
	# elevation
	if level_elevation_map == [] or elevation_sensitive == false:
		elevation_map = empty_map
	else:
		 elevation_map = level_elevation_map
	# forest
	if level_forest_map == [] or forest_sensitive == false:
		forest_map = empty_map
	else:
		 forest_map = level_forest_map
	# water
	if level_water_map == [] or water_sensitive == false:
		water_map = empty_map
	else:
		 water_map = level_water_map


func get_neighbors(pos):
	# pos is a Vector2 indexed from 0 to 9
	# find the 4 potential neighbors and return their indexes
	var neighbors = []
	# for each direction, check if:
	#   - index is within 0-9
	#   - the elevation gap is below 2
	#   - it's not over the left or right edge
	
	# find right neighbor:
	if pos.x + 1 < 10:
		if abs(elevation_map[pos.x][pos.y] - elevation_map[pos.x + 1][pos.y]) < 2:
			neighbors.append(Vector2(pos.x + 1, pos.y))
	if pos.x - 1 >= 0:
		if abs(elevation_map[pos.x][pos.y] - elevation_map[pos.x - 1][pos.y]) < 2:
			neighbors.append(Vector2(pos.x - 1, pos.y))
	if pos.y + 1 < 10:
		if abs(elevation_map[pos.x][pos.y] - elevation_map[pos.x][pos.y + 1]) < 2:
			neighbors.append(Vector2(pos.x, pos.y + 1))
	if pos.y - 1 >= 0:
		if abs(elevation_map[pos.x][pos.y] - elevation_map[pos.x][pos.y - 1]) < 2:
			neighbors.append(Vector2(pos.x, pos.y - 1))
	return neighbors

func _calculate_distances():
	# starts algo
	var i = 0
	var dist = 0
	var neighbors = get_neighbors(current_tile)
	if neighbors.size() == 0:
		return
	else:
		# while not every node is visited TODO: limit algo to max distance to improve performance
		while (unvisited_tiles.size() > 0) and ( i < 100000 ):
			# calculate distance to all unvisited neighbors of current node
			for neighbor in neighbors:
				if unvisited_tiles.has(neighbor):
					dist = 1 + max(abs(elevation_map[neighbor.x][neighbor.y] - elevation_map[current_tile.x][current_tile.y]), 0)\
							 + forest_map[neighbor.x][neighbor.y]\
							 + water_map[neighbor.x][neighbor.y]\
							 + distances[current_tile.x][current_tile.y]
					# if found a better distance, replace it in distance array
					if dist < distances[neighbor.x][neighbor.y]:
						distances[neighbor.x][neighbor.y] = dist
			
			# remove current tile from unvisited array
			unvisited_tiles.remove(unvisited_tiles.find(current_tile))
			
			# set new current tile to the unvisitied node with the smallest distance from current node:
			var min_distance = 99999
			for tile in unvisited_tiles:
				if distances[tile.x][tile.y] <= min_distance:
					current_tile = tile
					min_distance = distances[tile.x][tile.y]
			i = i + 1
			neighbors = get_neighbors(current_tile)

func get_distances():
	_calculate_distances()
	return  distances
