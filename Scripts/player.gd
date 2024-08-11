extends CharacterBody2D
class_name Player


@export var speed = 120
@export var jump_speed = -350
@export var gravity  = 1000

@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0, 1.0) var aceleration = 0.25

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("walk_left", "walk_right")
	if dir != 0:
		if dir == 1:
			$Sprite2D.flip_h = false
		elif dir == -1:
			$Sprite2D.flip_h = true
			
		velocity.x = lerp(velocity.x, dir * speed, aceleration)
	else:
		velocity.x = lerp(velocity.x,0.0, friction)
		
	move_and_slide()
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
