extends TileMap

var fnl := FastNoiseLite.new()
var dark_blue_tile = Vector2i(3,3)
var light_blue_tile = Vector2i(7,12)
@onready var tile_size = 4

@export var w = 300
@export var h = 150

func _ready()->void:
	randomize()
	fnl.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	fnl.seed = randi()
	generate_map()
	
func mapear(logica: Callable):
	for x in w:
		for y in h:
			logica.call(x, y)
	
func blank():
	mapear(func (x, y): set_cell(0,Vector2i(x,y), 0, light_blue_tile))
	
func suelo():
	mapear(func (x, y): if y == h - 1: set_cell(0, Vector2i(x,y), 0, dark_blue_tile))
	
func noise():
	mapear(func (x, y): 
		var noise := fnl.get_noise_2d(x,y)
		if noise < 0.14:
			set_cell(0,Vector2i(x,y),0,dark_blue_tile)
		)
	
func generate_map()->void:
	blank()
	noise()	
	suelo()

func _input(event : InputEvent)->void:
	if event.is_action_pressed("restart_world"):
		#generate_map()
		get_tree().reload_current_scene()
		
func get_spawn_tile() -> Vector2:
	var atlas_cord = null
	var position_spawn = null
	
	# Tomamos puntos al azar en [(50, 30), (200, 120)]
	# hasta que caiga en tile celeste
	while atlas_cord != light_blue_tile:
		var rand_x = randi_range(50, 200)
		var rand_y = randi_range(30, 120)		
		position_spawn = Vector2(rand_x, rand_y)	
		atlas_cord = get_cell_atlas_coords(0, position_spawn)
		
	return position_spawn
		
func get_spawn_point() -> Vector2:
	return get_spawn_tile() * tile_size
	
