extends CharacterBody2D
class_name Nave

const BULLET = preload("res://nave/bullet.tscn")
const speed = 300.0
signal player_shoot
var direction_to_rotation = {
	Vector2(1, 0): 90,     # Derecha
	Vector2(1, 1): 135,    # Derecha abajo
	Vector2(1, -1): 45,    # Derecha arriba
	Vector2(-1, 0): -90,   # Izquierda
	Vector2(-1, 1): -135,  # Izquierda abajo
	Vector2(-1, -1): -45,  # Izquierda arriba
	Vector2(0, 1): 180,    # Abajo
	Vector2(0, -1): 0      # Arriba	
}

func _physics_process(_delta):
	var horizontal = Input.get_axis("izquierda", "derecha")
	var vertical = Input.get_axis("arriba", "abajo")
	var disparar = Input.is_action_just_pressed("disparar")
	var direction  = Vector2(horizontal,vertical)
	
	if disparar:
		shoot()
		player_shoot.emit()

	#Mover el sprite del personaje
	if direction in direction_to_rotation:
		$".".rotation_degrees = direction_to_rotation[direction]

	#moverse
	velocity.x = speed * horizontal
	velocity.y = speed * vertical

	move_and_slide()

func shoot():
	var bullet_instance = BULLET.instantiate()
	var bullet_position = $Position.global_position # Ajusta según la posición global del nodo actual
	var direction = calculate_direction(bullet_position)
	bullet_instance.set_direction(direction)
	bullet_instance.global_position = bullet_position
	get_tree().call_group("level1_group", "add_child", bullet_instance)
	
func calculate_direction(bullet_position:Vector2) -> int:
	if (bullet_position.x > $".".position.x and bullet_position.y == $".".position.y):
		return 5
	elif (bullet_position.x < $".".position.x and bullet_position.y == $".".position.y):
		return 6
	elif (bullet_position.x == $".".position.x and bullet_position.y < $".".position.y):
		return 8
	elif (bullet_position.x == $".".position.x and bullet_position.y > $".".position.y):
		return 7
	elif (bullet_position.x > $".".position.x and bullet_position.y > $".".position.y):
		return 1
	elif (bullet_position.x > $".".position.x and bullet_position.y < $".".position.y):
		return 3
	elif (bullet_position.x < $".".position.x and bullet_position.y > $".".position.y):
		return 4
	else:
		return 2
	
