extends Node2D
@export var player_scene : PackedScene
var player_instance : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player_instance = player_scene.instantiate()
	player_instance.position = await $World/TileMap.get_spawn_point() * 4
	await wait()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func wait():
	await get_tree().create_timer(1).timeout
	self.add_child(player_instance)
