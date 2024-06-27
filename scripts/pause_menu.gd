extends Control

@onready var animation = $AnimationPlayer

func _ready():
	hide()
	animation.play("RESET")

func resume():
	get_tree().paused = false
	animation.play_backwards("Blur")
	hide()

func pause():
	show()
	print(Input)
	get_tree().paused = true
	animation.play("Blur")

func testEsc():
	if Input.is_action_just_pressed("Esc") and !get_tree().paused:
		visible = true
		print(Input)
		pause()
	elif Input.is_action_just_pressed("Esc") and get_tree().paused:
		visible = false
		print(Input)
		resume()


func _on_resume_pressed():
	resume()
	print(get_tree())


func _on_quit_pressed():
	resume()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _process(_delta):
	testEsc()


func _on_restart_pressed():
	resume()
	GameManager.set_score(Global.level_number, 0)
	#get_tree().change_scene_to_file("res://scenes/level"+str(Global.level_number)+".tsnc")
	get_tree().reload_current_scene()
