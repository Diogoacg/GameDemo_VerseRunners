extends Area2D

@onready var label_8 = $"../labels/label8"

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
#const MAIN_MENU = preload("res://scenes/main_menu.tscn") as PackedScene
#const MainMenu = preload("res://scripts/main_menu.gd")
@onready var animation_player = $"../AnimationPlayer"
@onready var timer = $"../CanvasLayer/Timer"




var coins_objective = false
var portal_open = false
var animation_playing = false

func _process(_delta):
	var coins = GameManager.get_score(0)
	
	if (not coins_objective ):
		if coins < 5:
			label_8.text = "You need " + str(5 - coins) + " more Coins"
		else:
			label_8.text = "Good Job!!"
			animated_sprite_2d.play("portal opening")
			coins_objective = true
			portal_open = true
			animation_playing = true
			
	if portal_open and not animation_playing:
		animated_sprite_2d.play("Idle")


func _on_animated_sprite_2d_animation_finished():
	animation_playing = false

func _on_body_entered(body):
	var coins = GameManager.get_score(0)
	print(coins)
	if coins >= 5:
		body.visible = false
		animation_player.play("fade_in")
		timer.hide()
		


func _on_animation_player_animation_finished(_anim_name):
	GameManager.scores[0]=0
	get_tree().change_scene_to_file.bind("res://scenes/level0.tscn").call_deferred()
