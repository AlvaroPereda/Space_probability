extends CharacterBody2D
class_name Nave

const speed = 300.0
signal player_shoot
var direction_to_rotation  = {
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
		player_shoot.emit()
	
	#Mover el sprite del personaje
	if direction in direction_to_rotation:
		$".".rotation_degrees = direction_to_rotation[direction]

	#moverse
	velocity.x = speed * horizontal
	velocity.y = speed * vertical

	move_and_slide()	
