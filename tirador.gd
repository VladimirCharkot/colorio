extends CharacterBody2D

var proyectil = preload("res://proyectil.tscn")

var max_shoot_force = 2000;
var shoot_force = 0;
var direction_angle = 1;
var shoot_force_step = 500;
@onready var indicador_angulo = $IndicadorAngulo;


# Called when the node enters the scene tree for the first time.
func _ready():
	$Animacion.play("desenfundar")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("shoot") and shoot_force < max_shoot_force:
		if (shoot_force + shoot_force_step) > max_shoot_force:
			shoot_force = max_shoot_force
		shoot_force += (shoot_force_step * delta)
		indicador_angulo.actualizar_potencia(shoot_force,max_shoot_force)
		print(shoot_force)
		
	if Input.is_action_just_released("shoot"):
		shoot_projectile();
		shoot_force = 0;
		indicador_angulo.actualizar_potencia(0,max_shoot_force)
	
	if Input.is_action_pressed("angle_up"):
		add_child(indicador_angulo)
		direction_angle += 0.3 * delta
		indicador_angulo.actualizar_angulo(direction_angle-1)
		print(direction_angle)
		
	if Input.is_action_pressed("angle_down"):
		add_child(indicador_angulo)
		direction_angle -= 0.3 * delta
		indicador_angulo.actualizar_angulo(direction_angle-1)
			
		print(direction_angle)

func shoot_projectile():
	var disparado = proyectil.instantiate()
	disparado.linear_velocity = Vector2.from_angle(PI * direction_angle) * shoot_force
	add_child(disparado)
