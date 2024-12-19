extends Node2D

@onready var pipe_pair = $"."

func _on_timer_timeout():
	pipe_pair.queue_free()
