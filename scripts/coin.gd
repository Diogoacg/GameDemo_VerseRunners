extends Area2D


func _on_body_entered(_body):
	
	GameManager.add_point()

	queue_free()
