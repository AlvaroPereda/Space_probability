extends Node2D
class_name GameController

var remaining_prob = 100
signal prob

func _on_player_hit():
	call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_file("res://nave/start.tscn")

func _on_player_pickup_star():
	remaining_prob = 100
	prob.emit(remaining_prob)

func _on_nave_player_shoot():
	if player_loses():
		_on_player_hit()
	else:
		remaining_prob -= 1
		remaining_prob = max(remaining_prob, 0)  # Asegurarse de que no baje de 0
		prob.emit(remaining_prob)

func player_loses() -> bool:
	var random_number = randi() % 101
	return random_number > remaining_prob
	
