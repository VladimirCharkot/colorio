extends Line2D
var potencia_curva:Curve = preload('res://PotenciaDisparoCurve.tres')

func actualizar_angulo(angle):
	var end_point = Vector2(-50, 0).rotated(PI * angle)
	self.points = PackedVector2Array([Vector2(0, 0), end_point])

func actualizar_potencia(potencia,potenciaMaxima):
	var ratio=potencia/potenciaMaxima 
	potencia_curva.set_point_value(1,1 + ratio * 10)
	self.width_curve=potencia_curva

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
