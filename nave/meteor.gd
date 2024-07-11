extends Node2D
class_name Meteor

var speed = 100
var value: int
var viewport: Vector2
signal player_hit

var direction_map = {
	1: Vector2(1, 1), 
	2: Vector2(-1, -1),
	3: Vector2(1, -1),
	4: Vector2(-1, 1),
	5: Vector2(1,0),
	6: Vector2(-1,0),
	7: Vector2(0,1),
	8: Vector2(0,-1),
}

func _process(delta):
	if value in direction_map:
		var direction = direction_map[value]
		global_position += direction * speed * delta
	if position.y < -20 or position.y > (viewport.y + 20) or position.x < -20 or position.x > (viewport.x + 20):
		queue_free() #Borra el meteorito 
	
func _on_area_2d_body_entered(body):
	if body is Nave:
		player_hit.emit()

func set_value_meteor(aux:int):
	value = aux
	
func set_viewport(aux:Vector2):
	viewport = aux
