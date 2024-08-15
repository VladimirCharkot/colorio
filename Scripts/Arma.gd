extends Sprite2D
var proyectil = preload("res://Scenes/proyectil.tscn")

var max_shoot_force = 2000;
var shoot_force = 0;
var direction_angle = 1;
var shoot_force_step = 500;
@onready var indicador_angulo = $IndicadorAngulo;
@onready var area_arma=$AreaArma

func _ready():
	$IndicadorAngulo.potenciaMaxima = max_shoot_force
	$IndicadorAngulo.a = PI

func _process(delta):
	
	if Input.is_action_pressed("shoot"):
		increase_shoot_force(delta)
		
	if Input.is_action_just_released("shoot"):
		shoot_projectile()
	
	if Input.is_action_pressed("angle_up"):
		direction_angle += 0.3 * delta
		indicador_angulo.a += 0.3 * delta
		
	if Input.is_action_pressed("angle_down"):
		direction_angle -= 0.3 * delta
		indicador_angulo.a -= 0.3 * delta

func shoot_projectile():
	var disparado = proyectil.instantiate()
	#disparado.set_collision_layer_value()
	
	disparado.linear_velocity = Vector2.from_angle(PI * direction_angle) * shoot_force
	print(disparado.linear_velocity)
	add_child(disparado)
	shoot_force = 0
	indicador_angulo.p = 0
	
func increase_shoot_force(delta):
	shoot_force += shoot_force_step * delta
	shoot_force = clamp(shoot_force, 0, max_shoot_force)
	indicador_angulo.p = shoot_force
