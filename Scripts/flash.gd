extends Sprite2D

@onready var flash = $"."
@onready var timer = $Timer
var flashed = false

func _ready():
	flash.visible = false
func flash_func():
	flash.visible = true
	timer.start()

func _on_timer_timeout():
	flash.visible = false


func _on_pipes_bird_touched():
	if not flashed:
		flash_func()
	flashed = true
