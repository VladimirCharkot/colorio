extends Node2D

var item = preload("res://item.tscn")


func _on_timer_timeout():
	var i = item.instantiate()
	i.c = Colore.random_sesgado()
	i.position = Vector2(randf() * get_viewport_rect().size.x, 10)
	print(i.position)
	add_child(i)
