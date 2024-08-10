extends Sprite2D
var proyectil = preload("res://Armas/proyectil.tscn")

var max_shoot_force = 2000;
var shoot_force = 0;
var direction_angle = 1;
var shoot_force_step = 500;
@onready var indicador_angulo = $IndicadorAngulo;
@onready var area_arma=$AreaArma



# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("shoot") and shoot_force < max_shoot_force:
		if (shoot_force + shoot_force_step) > max_shoot_force:
			shoot_force = max_shoot_force
		shoot_force += (shoot_force_step * delta)
		indicador_angulo.actualizar_potencia(shoot_force,max_shoot_force)
		
	if Input.is_action_just_released("shoot"):
		shoot_projectile();
		shoot_force = 0;
		indicador_angulo.actualizar_potencia(0,max_shoot_force)
	
	if Input.is_action_pressed("angle_up"):
		direction_angle += 0.3 * delta
		indicador_angulo.actualizar_angulo(direction_angle-1)
		
	if Input.is_action_pressed("angle_down"):
		direction_angle -= 0.3 * delta
		indicador_angulo.actualizar_angulo(direction_angle-1)

func shoot_projectile():
	var disparado = proyectil.instantiate()
	disparado.set_collision_layer_value()
	disparado.linear_velocity = Vector2.from_angle(PI * direction_angle) * shoot_force
	add_child(disparado)
	
