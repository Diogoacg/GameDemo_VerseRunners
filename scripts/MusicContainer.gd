extends PanelContainer
@onready var previous = $VBoxContainer/HBoxContainer/Previous
@onready var pause = $VBoxContainer/HBoxContainer/Pause
@onready var next = $VBoxContainer/HBoxContainer/Next
const PLAY = preload("res://assets/UI/Prinbles_GUI_Asset_Silent (1.0.0)/asset/png/Buttons/Square-Medium/SoundOff/play.tres")
const PLAY_HOVER = preload("res://assets/UI/Prinbles_GUI_Asset_Silent (1.0.0)/asset/png/Buttons/Square-Medium/SoundOff/playHover.tres")
const PAUSE = preload("res://assets/UI/Prinbles_GUI_Asset_Silent (1.0.0)/asset/png/Buttons/Square-Medium/SoundOn/pause.tres")
const PAUSE_HOVER = preload("res://assets/UI/Prinbles_GUI_Asset_Silent (1.0.0)/asset/png/Buttons/Square-Medium/SoundOn/pauseHover.tres")

func _ready():
	checkAudio()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_previous_button_down():
	checkAudio()
	Audio2d._on_PreviousButton_pressed()

func _on_next_button_down():
	checkAudio()
	Audio2d._on_NextButton_pressed()


func _on_pause_button_down():
	Audio2d.toggle_play_pause()
	checkAudio()
	
func checkAudio():
	if Audio2d.stream_paused == false:
		pause.add_theme_stylebox_override("normal", PLAY)
		pause.add_theme_stylebox_override("hover", PLAY_HOVER)
		pause.add_theme_stylebox_override("pressed",  PLAY_HOVER)
		pause.add_theme_stylebox_override("focus",  PLAY_HOVER)
	else:
		pause.add_theme_stylebox_override("normal", PAUSE)
		pause.add_theme_stylebox_override("hover", PAUSE_HOVER)
		pause.add_theme_stylebox_override("pressed",PAUSE_HOVER)
		pause.add_theme_stylebox_override("focus", PAUSE_HOVER)
