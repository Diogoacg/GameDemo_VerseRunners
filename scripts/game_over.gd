extends Control
@onready var animation_player = $AnimationPlayer

@onready var exit = $Exit
@onready var play_again = $PlayAgain

func _on_play_again_button_down():
	animation_player.play("fade_in")
	
func _on_exit_button_down():
	animation_player.play("fade_in_2")
	
func _on_animation_player_animation_finished(anim_name):
	GameManager.scores[0]=0
	if anim_name == "fade_in":
		get_tree().change_scene_to_file("res://scenes/level0.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/level0.tscn")

