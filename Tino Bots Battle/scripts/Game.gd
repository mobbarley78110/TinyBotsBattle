extends Node2D

onready var main = get_tree().get_current_scene()
onready var land_tile_map = get_node('TileMaps/Land')
onready var robot_tile_map = get_node('TileMaps/Robots')
onready var move_tile_map = get_node('TileMaps/Move')
onready var tile_map = get_node('TileMaps')
onready var player_label = get_node("ui/PlayerTurn")
onready var points_label = get_node("ui/PointsLeft")
onready var level_vars = get_node('/root/LevelVariables')

var selected_unit
var active_player = 0
var robot_grid = []

# players stuff
var player_init_energy = [10, 10]
var player_left_energy = player_init_energy.duplicate()

func _ready():
	points_label.set_text('Points left:' + str(player_left_energy[active_player]))
	robot_grid = level_vars.empty_grid.duplicate()
	for robot in robot_tile_map.get_children():
		robot_grid[robot.pos.x][robot.pos.y] = robot

	
func select_unit(unit):
	if selected_unit != unit:
		unit.action_points_left = player_left_energy[active_player]
		if unit.action_points_left > 0 and unit.player == active_player :
			selected_unit = unit
			# play Iddle scripte of selected unit
			unit.get_node('Sprite').play()
			# show accessible tiles here if there's any movement possible.
			robot_tile_map._update_move_tiles(unit)

func deselect_unit():
	if selected_unit != null:
		selected_unit.get_node('Sprite').stop()
		# turn off 
		for tile in selected_unit.get_node('../../Move').get_children():
			tile.visible = false
		selected_unit = null

func _input(event):
	# LEFT CLICK
	var mouse = get_global_mouse_position()
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		var ui_rect = self.get_node("ui/tex").get_global_rect()
		# deselect unit if click not on the ui board bellow (might beed to add more to this)
		if not (mouse.x >= ui_rect.position.x and mouse.x <= ui_rect.position.x + ui_rect.size.x
		and mouse.y >= ui_rect.position.y and mouse.y <= ui_rect.position.y + ui_rect.size.y):
			self.deselect_unit()
	# RIGHT CLICK
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT):
		# move selected unit
		if selected_unit != null:
			#select_unit(selected_unit) # not sure why this was here??
			if floor(player_left_energy[active_player] / selected_unit.moving_cost) > 0:
				var tile_coords = robot_tile_map.world_to_map(mouse - tile_map.position)
				if selected_unit.move_distances[tile_coords.x][tile_coords.y] <= player_left_energy[active_player] / selected_unit.moving_cost \
				and robot_grid[tile_coords.x][tile_coords.y] == null:
					robot_grid[selected_unit.pos.x][selected_unit.pos.y] = null
					selected_unit.pos = tile_coords
					robot_grid[selected_unit.pos.x][selected_unit.pos.y] = selected_unit
					player_left_energy[active_player] -= selected_unit.move_distances[tile_coords.x][tile_coords.y] * selected_unit.moving_cost
					selected_unit._update_pos()
					robot_tile_map._update_move_tiles(selected_unit)
					points_label.set_text('Points left:' + str(player_left_energy[active_player]))

func _on_Button_button_up():
	deselect_unit()
	# reset player energy
	player_left_energy[active_player] = player_init_energy[active_player]
	# change active player
	active_player = (active_player + 1 ) % 2
	player_label.set_text('Player ' + str(active_player + 1))
	points_label.set_text('Points Left: ' + str(player_left_energy[active_player]))

	
	

