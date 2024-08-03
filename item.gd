extends RigidBody2D

class_name Item

var c: Color

# Called when the node enters the scene tree for the first time.
func _ready():
	if c:
		$Sprite.modulate = c
