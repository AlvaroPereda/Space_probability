extends Node2D
class_name Star

signal star_destroyed

func _on_area_2d_body_entered(body):
	if body is Nave:
		queue_free()
		star_destroyed.emit() 
