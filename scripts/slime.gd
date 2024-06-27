extends Node2D

const SPEED = 60

var direction = 1

@onready var ray_cast_dir = $RayCastDir
@onready var ray_cast_esq = $RayCastEsq
@onready var ray_cast_cima = $RayCastCima
@onready var animation_player = $AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_dir.is_colliding():
		direction = -1
	if ray_cast_esq.is_colliding():
		direction = 1
	#if ray_cast_cima.is_colliding():
		#queue_free()
	position.x += direction * SPEED * delta


func _on_body_entered(body):
	body.get_node("CollisionShape2D").queue_free()
	animation_player.play("fade_in")


func _on_animation_player_animation_finished(_anim_name):
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
