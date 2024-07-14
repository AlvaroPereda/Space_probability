extends Node2D
class_name ui

func _on_game_controller_prob(aux: int):
	$prob_label.text = str(aux,"%")

func _on_game_controller_record(aux: int):
	$record.text = str("Record: ",aux)
