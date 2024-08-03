extends CharacterBody2D

var proyectil = preload("res://proyectil.tscn")

var shoot_force = 600;
var direction_angle = 1.40
# Called when the node enters the scene tree for the first time.
func _ready():
	$Animacion.play("desenfundar")
	var disparado = proyectil.instantiate()
	print(Vector2.from_angle(PI * direction_angle))
	disparado.linear_velocity = Vector2.from_angle(PI * direction_angle) * shoot_force
	add_child(disparado)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
