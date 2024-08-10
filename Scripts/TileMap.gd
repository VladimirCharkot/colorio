extends TileMap

var fnl := FastNoiseLite.new()
var dark_blue_tile = Vector2i(3,3)
var light_blue_tile = Vector2i(7,12)

func _ready()->void:
	randomize()
	fnl.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	fnl.seed = randi()
	generate_map()
	
func generate_map()->void:
	for x in 300:
		for y in 150:			
			if y == 149:
				set_cell(0,Vector2i(x,y),0,dark_blue_tile)
				continue
			var noise := fnl.get_noise_2d(x,y)
			if noise < 0.14:
				set_cell(0,Vector2i(x,y),0,dark_blue_tile)
			else:
				set_cell(0,Vector2i(x,y),0,light_blue_tile)
				
	get_spawn_point()
func _input(event : InputEvent):
	if event.is_action_pressed("restart_world"):
		get_tree().reload_current_scene();
func get_spawn_point()->Vector2:
	var atlas_cord = Vector2i(0,0)
	var position_spawn = Vector2()
	while atlas_cord != light_blue_tile:
		var rand_x = randi_range(50,200)
		var rand_y = randi_range(30,120)		
		position_spawn = Vector2(rand_x,rand_y)	
		atlas_cord = get_cell_atlas_coords(0,position_spawn)
		
	print(position_spawn)
	print(get_cell_atlas_coords(0,position_spawn))
	return position_spawn
		
		
	
