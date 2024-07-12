extends Node2D
class_name level

const meteor = preload("res://nave/meteor.tscn")
const star = preload("res://nave/star.tscn")
const BULLET = preload("res://nave/bullet.tscn")
var player: Node2D
var distancia_spawn:int = 20
var game_controller: Node

func _ready():
	player = get_node("nave")
	game_controller = get_node("GameController")
	create_star()

func generate_meteor():
	var meteor_instance = meteor.instantiate()
	var rng = RandomNumberGenerator.new()
	var screen = get_viewport().size 
	var meteor_x: float
	var meteor_y: float
	var side = rng.randi_range(0,3)
	
	match side:
		0: #Izquierda
			meteor_x = -distancia_spawn
			meteor_y = rng.randi_range(-distancia_spawn,screen.y + distancia_spawn)
		1: #Arriba
			meteor_x = rng.randi_range(-distancia_spawn,screen.x + distancia_spawn)
			meteor_y = -distancia_spawn
		2: #Derecha
			meteor_x = screen.x + distancia_spawn
			meteor_y = rng.randi_range(-distancia_spawn,screen.y + distancia_spawn)
		3: #Abajo
			meteor_x = rng.randi_range(-distancia_spawn,screen.x + distancia_spawn)
			meteor_y = screen.y + distancia_spawn 
		
	var value = calculate_value(meteor_x,meteor_y)
	meteor_instance.set_value_meteor(value)
	add_child(meteor_instance)
	meteor_instance.global_position = Vector2(meteor_x,meteor_y)
	meteor_instance.connect("player_hit",Callable(game_controller,"_on_player_hit"))

func calculate_value(meteor_x: float, meteor_y: float) -> int: #Calcula la dirección del meteorito
	if (meteor_x < player.global_position.x) and (meteor_y + distancia_spawn > player.global_position.y and meteor_y - distancia_spawn < player.global_position.y): 
		return 5
	elif (meteor_x > player.global_position.x) and (meteor_y + distancia_spawn > player.global_position.y and meteor_y - distancia_spawn < player.global_position.y): 
		return 6
	elif (meteor_x + distancia_spawn > player.global_position.x and meteor_x - distancia_spawn < player.global_position.x) and (meteor_y < player.global_position.y): 
		return 7
	elif (meteor_x + distancia_spawn > player.global_position.x and meteor_x - distancia_spawn < player.global_position.x) and (meteor_y > player.global_position.y): 
		return 8
	elif (meteor_x < player.global_position.x) and (meteor_y < player.global_position.y): #primer cuadrante
		return 1
	elif (meteor_x > player.global_position.x) and (meteor_y > player.global_position.y): #cuarto cuadrante
		return 2
	elif (meteor_x < player.global_position.x) and (meteor_y > player.global_position.y): #tercer cuadrante
		return 3
	else:
		return 4

func _on_timer_timeout():
	generate_meteor()

func _on_star_star_destroyed():
	call_deferred("create_star")

func create_star():
	var star_instance = star.instantiate()
	var rng = RandomNumberGenerator.new()
	var screen = get_viewport().size
	var star_x: float
	var star_y: float
	
	star_x = rng.randi_range(5,screen.x - 5)
	star_y = rng.randi_range(5,screen.y - 5)
	
	add_child(star_instance)
	star_instance.global_position = Vector2(star_x,star_y)
	star_instance.connect("star_destroyed",_on_star_star_destroyed) #Esto conecta la señal con la función, ya que al borrarlo se pierde la conexión 
	star_instance.connect("star_destroyed",Callable(game_controller,"_on_player_pickup_star"))
