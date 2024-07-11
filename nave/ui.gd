extends Node2D
class_name ui

func _on_game_controller_prob(aux:int):
	$prob_label.text = str(aux,"%")
