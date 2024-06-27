extends Area2D


@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	print("KILLZONE")
	if body.name == "Player" or body.name == "Player1" or body.name == "Player2" or body.name == "Player3":
		body.die()
	pass

func _on_animation_player_animation_finished(_anim_name):
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
