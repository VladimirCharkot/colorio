extends CharacterBody2D

var proyectil = preload("res://proyectil.tscn")

var max_shoot_force = 2000;
var shoot_force = 0;
var direction_angle = 0;
var shoot_force_step = 500;
# Called when the node enters the scene tree for the first time.
func _ready():
	$Animacion.play("desenfundar")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("shoot") and shoot_force < max_shoot_force:
		if (shoot_force + shoot_force_step) > max_shoot_force:
			shoot_force = max_shoot_force
		shoot_force += (shoot_force_step * delta)
		print(shoot_force)
		
	if Input.is_action_just_released("shoot"):
		shoot_projectile();
		shoot_force = 0;
	
	if Input.is_action_pressed("angle_up"):
		if direction_angle < 2:
			direction_angle += 1 * delta
		print(direction_angle)
		
	if Input.is_action_pressed("angle_down"):
		if direction_angle > -2:
			direction_angle -= 0.1 * delta
		print(direction_angle)

func shoot_projectile():
	var disparado = proyectil.instantiate()
	disparado.linear_velocity = Vector2.from_angle(PI * direction_angle) * shoot_force
	add_child(disparado)
