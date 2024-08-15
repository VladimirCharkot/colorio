extends RigidBody2D

class_name Proyectil
const speed = 3
func _ready():
	get_tree().create_timer(3).timeout.connect(func (): queue_free())

func _on_area_2d_body_entered(body: Node):
	if body is TileMap:
		var collision_point = global_position		
		body.destroy_tiles(collision_point)
		queue_free()
