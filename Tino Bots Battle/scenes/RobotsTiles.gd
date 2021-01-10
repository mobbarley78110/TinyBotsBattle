extends TileMap

var tile_size = get_cell_size()
var grid_size = 10
var iso_coord_sorted =  []

# load level:
onready var level_vars = get_node('/root/LevelVariables')
onready var main = get_node('/root/Game')
var forest_positions = []
var elevations = []
var water_positions = []

# load bot scene
onready var Character = preload('res://scenes/Character.tscn')

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
	
	# instance 4 bots for p1
	var bots_1_positions = [[0,8], [0,9], [1,8], [1,9]]
	for i in range(len(bots_1_positions)):
		var robot = Character.instance()
		robot.pos = Vector2(bots_1_positions[i][0],bots_1_positions[i][1])
		robot.set_position(map_to_world(robot.pos))
		robot.set_name('robot_1_' + str(i))
		robot.player = 0
		add_child(robot)
	
	# instance 4 for bots p2
	var bots_2_positions = [[8,0], [8,1], [9,0], [9,1]]
	for i in range(len(bots_1_positions)):
		var robot = Character.instance()
		robot.pos = Vector2(bots_2_positions[i][0],bots_2_positions[i][1])
		robot.set_position(map_to_world(robot.pos))
		robot.set_name('robot_2_' + str(i))
		robot.player = 1
		add_child(robot)
	
func _update_move_tiles(robot):
	# hide all existing tiles
	robot._update_distances()
	for z in iso_coord_sorted:
		get_node('../Move/new_move_tile' + str(z)).visible = false
		if robot.move_distances[z.x][z.y] <= main.player_left_energy[main.active_player] / robot.moving_cost and robot.move_distances[z.x][z.y] > 0:
			get_node('../Move/new_move_tile' + str(z)).visible = true
