extends StaticBody2D
class_name Bullet

var speed = 400
var value: int
var direction_map = {
	1: Vector2(1, 1), #Abajo derecha
	2: Vector2(-1, -1), #Arriba izquierda
	3: Vector2(1, -1), #Arriba derecha
	4: Vector2(-1, 1), #Abajo izquierda
	5: Vector2(1,0), #Derecha
	6: Vector2(-1,0), #Izquierda
	7: Vector2(0,1), #Arriba
	8: Vector2(0,-1), #Abajo
}

func _process(delta):
	if value in direction_map:
		var direction = direction_map[value]
		global_position += direction * speed * delta

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func set_direction(aux:int):
	value = aux

func _on_bullet_destroyed():
	print("Bala destruida")
	queue_free()
