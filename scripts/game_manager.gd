extends Node

var level_times = {}
var scores = [0, 0, 0, 0, 0]
var times = [0, 0, 0, 0, 0]
var latest_time = [0, 0]
var player_name

func timeToFormat(time: int) -> String:
	var milisecs = time % 1000
	@warning_ignore("integer_division")
	var timeInSecs = time / 1000
	@warning_ignore("integer_division")
	var minutes = timeInSecs / 60
	var seconds = timeInSecs % 60
	var formatted_time = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2) + ":" + str(milisecs).pad_zeros(3)
	return formatted_time

func add_point():
	var score = scores[0]
	if score == 5:
		scores[0] = 0
		score = 0
	score += 1
	scores[0] = score
	
func get_score(level):
	return scores[level]

var timer_on = false

func set_score(level, score):
	scores[level] = score

