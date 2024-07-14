extends Node2D
class_name GameController

var remaining_prob: int = 100
var PUNCTUATION: int = 0
var RECORD: int
var save_path = "user://punctuation.dat"
signal prob
signal record
signal punctuation

func _ready():
	load_game()
	record.emit(RECORD)

func _on_player_hit():
	call_deferred("change_scene")

func _on_meteor_destroyed():
	PUNCTUATION += 1
	punctuation.emit(PUNCTUATION)
	if PUNCTUATION > RECORD:
		record.emit(PUNCTUATION)
		save_game()

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
	
func save_game():
	var save_file = FileAccess.open(save_path,FileAccess.WRITE)
	save_file.store_var(punctuation)
	save_file = null
	
func load_game():
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path,FileAccess.READ)
		RECORD = save_file.get_var()
		save_file = null
	else:
		print("No encontrado")
