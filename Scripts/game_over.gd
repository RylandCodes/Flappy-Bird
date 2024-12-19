extends Sprite2D
@onready var timer = $Timer

@onready var game_over = $"."
@onready var animation_player = $AnimationPlayer
var played = false

func _ready():
	game_over.visible = false
func _on_pipes_bird_touched():
	if not played:
		game_over.visible = true
		animation_player.play("scale")
		played = true
		timer.start()
		


func _on_timer_timeout():
	animation_player.play("goaway")
	
