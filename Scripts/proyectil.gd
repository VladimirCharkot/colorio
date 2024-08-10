extends RigidBody2D

class_name Proyectil

func _ready():
	get_tree().create_timer(3).timeout.connect(func (): queue_free())
