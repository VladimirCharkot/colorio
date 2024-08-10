extends Node

class_name Colore

static func random():
	return Color(randf(), randf(), randf())
	
static func random_sesgado():
	var caso = randi_range(1, 6)
	var maximo = 0.4 + randf() * 0.6
	var medio = 0.1 + randf() * 0.4
	var minimo = randf() * 0.2
	match caso:
		1:
			return Color(maximo, medio, minimo)
		2:
			return Color(maximo, minimo, medio)
		3:
			return Color(medio, maximo, minimo)
		4:
			return Color(medio, minimo, maximo)
		5: 
			return Color(minimo, maximo, medio)
		6:
			return Color(minimo, medio, maximo)

static func clamp(value: Color):
	return Color(clamp(value.r, 0, 1), clamp(value.g, 0, 1), clamp(value.b, 0, 1))

static func barritas_stats(c: Color):
	var w = 80
	var r = c.r
	var g = c.g
	var b = c.b
	return {
		'r': [Vector2(-w/2, -60), Vector2(-w/2 + r * w, -60)],
		'g': [Vector2(-w/2, -45), Vector2(-w/2 + g * w, -45)],
		'b': [Vector2(-w/2, -30),  Vector2(-w/2 + b * w, -30)]
	}
