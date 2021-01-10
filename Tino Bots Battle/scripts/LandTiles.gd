extends TileMap

# initial params
var tile_size = get_cell_size()
var grid_size = 10
var iso_coord_sorted =  []

# load level:
onready var level_vars = get_node('/root/LevelVariables')

# load tiles
onready var Forest = preload('res://scenes/Forest.tscn')
onready var Water = preload('res://scenes/Water.tscn')
onready var Elev_1 = preload('res://scenes/Elev_1.tscn')
onready var Elev_2 = preload('res://scenes/Elev_2.tscn')
onready var Floor = preload('res://scenes/Floor.tscn')
onready var mouse_pos_label = get_node('../MousePosition')

var forest_positions = []
var elevations = []
var water_positions = []

func _ready():
	# iterate on grid's diagonals to create sorted coordinates
	for d in range(0, 2 * grid_size):
		for i in range(0, d + 1):
			if (i < grid_size) and (d-i < grid_size):
				iso_coord_sorted.append(Vector2(i, d-i))
				
	# load level map from level_vars
	forest_positions = level_vars.forest_position
	elevations = level_vars.elevation_map
	water_positions = level_vars.water_position
	
	# instance tiles
	for z in iso_coord_sorted:
		var pos = Vector2(map_to_world(z).x, map_to_world(z).y - 3 * elevations[z.x][z.y])
		if water_positions[z.x][z.y] == 1:
			var new_water = Water.instance()
			new_water.set_position(pos)
			new_water.set_name("water" + str(z))
			add_child(new_water)
		elif forest_positions[z.x][z.y] == 1:
			var new_forest = Forest.instance()
			new_forest.set_position(pos)
			new_forest.set_name("forest" + str(z))
			add_child(new_forest)
		else:
			var new_floor = Floor.instance()
			new_floor.set_position(pos)
			new_floor.set_name("floor" + str(z))
			add_child(new_floor)


func _process(delta):
	# text labels for debugging
	var mouse_pos_vec2 = get_viewport().get_mouse_position() - self.global_position
	var tile_coords = world_to_map(mouse_pos_vec2)
	mouse_pos_label.set_text(str(tile_coords))


