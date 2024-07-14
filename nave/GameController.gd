extends Node2D
class_name GameController

var remaining_prob: int = 100
var punctuation: int = 0
signal prob
signal record

func _on_player_hit():
	call_deferred("change_scene")

func _on_meteor_destroyed():
	punctuation += 1
	record.emit(punctuation)

func change_scene():
	get_tree().change_scene_to_file("res://nave/start.tscn")

func _on_player_pickup_star():
	remaining_prob = min(remaining_prob + 5, 100)
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
	
