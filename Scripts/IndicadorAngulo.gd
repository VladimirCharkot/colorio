extends Line2D
var potencia_curva:Curve = preload('res://Scripts/PotenciaDisparoCurve.tres')

var a = 0
var p = 0
var potenciaMaxima = 1

func _process(delta):
	actualizar_angulo(a)
	actualizar_potencia(p)

func actualizar_angulo(angle):
	var end_point = Vector2(-50, 0).rotated(PI * angle)
	points = PackedVector2Array([Vector2(0, 0), end_point])

func actualizar_potencia(potencia):
	var ratio = potencia/potenciaMaxima 
	potencia_curva.set_point_value(1,1 + ratio * 10)
	width_curve = potencia_curva
