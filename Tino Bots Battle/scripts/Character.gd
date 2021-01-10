extends Node2D

# load needed scenes / nodes
onready var Move_Tile = preload('res://scenes/MoveTile.tscn')
onready var level_vars = get_node('/root/LevelVariables')
onready var robot_tile_map = get_node('/root//Game/TileMaps/Robots')
onready var main = get_node('/root//Game')
var elevations = []

# characteristics
var action_points = 10
var health_points = 5
var moving_cost = 2
var shooting_range = 0
var shooting_power = 0
var shooting_cost = 0
var meelee_range = 1
var meelee_power = 2
var meelee_cost = 2

# in game stats
var is_selected = false
var is_alive = true
var health_left = health_points
var action_points_left = action_points
export var pos = Vector2(5, 5)
var move_distances
var player

func _ready():
	elevations = level_vars.elevation_map
	# instance the distances to move
	var move_distances_obj = Distance.new(pos, level_vars.elevation_map, level_vars.forest_position, level_vars.water_position)
	move_distances = move_distances_obj.get_distances()
	self.position = robot_tile_map.map_to_world(pos)

func _update_distances():
	var move_distances_obj = Distance.new(pos, level_vars.elevation_map, level_vars.forest_position, level_vars.water_position)
	move_distances = []
	move_distances = move_distances_obj.get_distances()

func _update_pos():
	self.position = robot_tile_map.map_to_world(pos) - Vector2(0, 3 * elevations[pos.x][pos.y])
