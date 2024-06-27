extends Node2D

@onready var timers = $CanvasLayer/Timer
@onready var label = $Player/Camera2D/Label
@onready var music = $CanvasLayer/MusicContainer/VBoxContainer/music

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

var timer = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	
	var mils = fmod(timer,1)*1000
	var secs = fmod(timer,60)
	var mins = fmod(timer, 60*60) / 60
	
	var time_passed = "%02d : %02d : %03d" % [mins,secs,mils]
	var text = time_passed# + " : " + var2str(time)
	
	timers.text = text
	label.text = str(GameManager.get_score(0))
	return text
	
