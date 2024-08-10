extends Node2D

var item = preload("res://Scenes/item.tscn")

func _ready():
	$PJ.position = $World.get_spawn_point()
	
func spawn_item():
	var i = item.instantiate()
	i.c = Colore.random_sesgado()
	i.position = $World.get_spawn_point()
	add_child(i)

func _on_timer_timeout():
	spawn_item()
