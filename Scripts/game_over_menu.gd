extends Node2D

@onready var score = $score
@onready var game_over_menu = $"."
@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer
@onready var high_score = $HighScore

var done = false

var score_int: int = 0

signal save_highscore

func _ready():
	game_over_menu.visible = false

func _on_pipes_bird_touched():
	timer.start()


func _on_timer_timeout():
	if not done:
		game_over_menu.global_position.y = 600
		game_over_menu.visible = true
		animation_player.play("Move")
		done = true


func _on_score_manager_bird_scored():
	score_int += 1
	score.text = str(score_int)


func _on_button_pressed():
	get_tree().reload_current_scene()


func _on_score_manager_change_highscore(changed_highscore):
	high_score.text = str(changed_highscore)
	save_highscore.emit(changed_highscore)


func _on_main_highscore_changed(changed_highscore):
	high_score.text = str(changed_highscore)
