extends Control
class_name start

func _on_button_pressed():
	get_tree().change_scene_to_file("res://nave/level_1.tscn")
