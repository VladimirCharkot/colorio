extends CharacterBody2D

var c = Color.BLACK

# rojo -> poder,
# verde -> velocidad,
# azul -> defensa

const MAX_SPEED = 600.0
const MAX_JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$Sprite.play("idle")

func _process(delta):
	queue_redraw()
	
	c = Colore.clamp(c)
	$Sprite.modulate = c
	
	if is_on_floor() and abs(velocity.x) > 1:
		$Sprite.play("walk")
		$Sprite.flip_h = velocity.x < 0
		
	if is_on_floor() and abs(velocity.x) < 1:
		$Sprite.play("idle")
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$Sprite.play("jump")
		
	
func _draw(): 
	var bs = Colore.barritas_stats(c)
	draw_line(bs['r'][0], bs['r'][1], Color.RED, 10)
	draw_line(bs['g'][0], bs['g'][1], Color.GREEN, 10)
	draw_line(bs['b'][0], bs['b'][1], Color.BLUE, 10)

func _physics_process(delta):
	var JUMP_VELOCITY = -260 + MAX_JUMP_VELOCITY * c.g
	var SPEED = 200 + MAX_SPEED * c.g
	var friccion = 0.9 + (0.19) * c.g
	
	print(friccion)
	
	# Add the gravity.
	if not is_on_floor():
		if velocity.y > 0:
			velocity.y += gravity * delta * 2
		else:
			velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x += direction * SPEED * 0.1
	else:
		velocity.x *= friccion

	move_and_slide()
	var col = get_last_slide_collision()
	if col:
		var cosa = col.get_collider()
		if cosa is Item:
			pickear_item(cosa)

# Color.lerp()
# Color.blend()

func pickear_item(item: Item):
	c = (c + item.c) / 2
	item.queue_free()
