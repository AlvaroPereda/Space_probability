extends Node2D
class_name ui

func _on_game_controller_prob(prob: int):
	$prob_label.text = str(prob,"%")

func _on_game_controller_record(record : int):
	$record.text = str("Record: ",record)

func _on_game_controller_punctuation(punctuation: int):
	$punctuation.text = str(punctuation)
	
