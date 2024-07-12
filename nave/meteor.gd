extends Node2D
class_name Meteor

var speed = 100
var value: int
@onready var viewport = get_viewport().size
signal player_hit

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
	if position.y < -20 or position.y > (viewport.y + 20) or position.x < -20 or position.x > (viewport.x + 20):
		queue_free() 
	
func _on_area_2d_body_entered(body):
	if body is Nave:
		player_hit.emit()
	elif body is Bullet:
		queue_free()

func set_value_meteor(aux:int):
	value = aux
