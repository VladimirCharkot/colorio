extends CharacterBody2D

var c = Color.BLACK

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$Sprite.play("idle")

func _process(delta):
	queue_redraw()
	
	c.r = clamp(c.r, 0, 1)
	c.g = clamp(c.g, 0, 1)
	c.b = clamp(c.b, 0, 1)
	
	modulate = c
	
	if is_on_floor() and abs(velocity.x) > 1:
		$Sprite.play("walk")
		$Sprite.flip_h = velocity.x < 0
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$Sprite.play("jump")
		
	if is_on_floor() and  abs(velocity.x) < 1:
		$Sprite.play("idle")
	
func _draw(): 
	var w = 80
	var r = c.r
	var g = c.g
	var b = c.b
	draw_line(Vector2(-w/2, -60), Vector2(-w/2 + r * w, -60), Color.RED, 10)
	draw_line(Vector2(-w/2, -45), Vector2(-w/2 + g * w, -45), Color.GREEN, 10)
	draw_line(Vector2(-w/2, -30),  Vector2(-w/2 + b * w, -30), Color.BLUE, 10)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	var col = get_last_slide_collision()
	if col:
		var cosa = col.get_collider()
		if cosa is Item:
			c += cosa.c * 0.1
			cosa.queue_free()
