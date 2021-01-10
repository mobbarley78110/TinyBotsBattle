extends TileMap

var tile_size = get_cell_size()
var grid_size = 10
var iso_coord_sorted =  []

# load level:
onready var level_vars = get_node('/root/LevelVariables')
var forest_positions = []
var elevations = []
var water_positions = []

# load move tile scene
onready var MoveTile = preload('res://scenes/MoveTile.tscn')

func _ready():
	# create the z coords
	for d in range(0, 2 * grid_size):
		for i in range(0, d + 1):
			if (i < grid_size) and (d-i < grid_size):
				iso_coord_sorted.append(Vector2(i, d-i))
				
	# load level map from level_vars
	forest_positions = level_vars.forest_position
	elevations = level_vars.elevation_map
	water_positions = level_vars.water_position
	
	# instance 100 move tiles
	for z in iso_coord_sorted:
		var pos = Vector2(map_to_world(z).x, map_to_world(z).y - 3 * elevations[z.x][z.y])
		var new_move_tile = MoveTile.instance()
		new_move_tile.set_position(pos)
		new_move_tile.visible = false
		new_move_tile.set_name('new_move_tile' + str(z))
		add_child(new_move_tile)

	#for z in iso_coord_sorted:
	#	var pos = Vector2(map_to_world(z).x, map_to_world(z).y - 3 * elevations[z.x][z.y])
	#	if robot.move_distances[z.x][z.y] <= robot.action_points_left / robot.moving_cost and robot.move_distances[z.x][z.y] > 0:
	#		var new_move_tile = MoveTile.instance()
	#		new_move_tile.set_position(pos-robot.position)
	#		new_move_tile.set_name('updated_move_tile' + str(z))
	#		robot.add_child(new_move_tile)
