extends RigidBody2D

class_name Item

var c: Color = Color.WHITE

func _ready():
	$Sprite.modulate = c

func _draw(): 
	var bs = Colore.barritas_stats(c)
	draw_line(bs['r'][0], bs['r'][1], Color.RED, 10)
	draw_line(bs['g'][0], bs['g'][1], Color.GREEN, 10)
	draw_line(bs['b'][0], bs['b'][1], Color.BLUE, 10)
