extends Node

@onready var label = $Label

signal bird_scored
signal change_highscore

var score: int = 0
var highscore = null

func _ready():
	label.text = str(score)

func _on_pipes_scored():
	score += 1
	if score > highscore:
		highscore = score
		change_highscore.emit(highscore)
	label.text = str(score)
	bird_scored.emit()


func _on_main_highscore_changed(changed_highscore):
	highscore = changed_highscore
