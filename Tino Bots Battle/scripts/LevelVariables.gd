extends Node

var grid_size = 10

var empty_grid = [
		[null, null, null, null, null, null, null, null, null, null],
		[null, null, null, null, null, null, null, null, null, null],
		[null, null, null, null, null, null, null, null, null, null],
		[null, null, null, null, null, null, null, null, null, null],
		[null, null, null, null, null, null, null, null, null, null],
		[null, null, null, null, null, null, null, null, null, null],
		[null, null, null, null, null, null, null, null, null, null],
		[null, null, null, null, null, null, null, null, null, null],
		[null, null, null, null, null, null, null, null, null, null],
		[null, null, null, null, null, null, null, null, null, null]]

var forest_position = [
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
		[0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
		[0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 1, 0, 0, 0, 0, 1, 1],
		[0, 0, 0, 1, 1, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 1, 1, 1]]

var water_position = [
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
		[0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
		[0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
		[0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 1, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 1, 1, 1, 1],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

var elevation_map = [
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 1, 1, 1, 0, 0],
	[0, 0, 0, 0, 0, 0, 2, 1, 0, 0],
	[0, 0, 0, 0, 0, 0, 2, 1, 0, 0],
	[0, 0, 0, 0, 0, 0, 2, 1, 0, 0],
	[0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
	[0, 1, 2, 2, 0, 0, 0, 1, 1, 2],
	[0, 0, 1, 1, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 1, 1, 2, 2]]

func _ready():
	pass
