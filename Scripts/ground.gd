extends Node2D

@export var speed = -450

@onready var ground = $"."

@onready var sprite = $Ground1/Sprite2D
@onready var sprite2 = $Ground2/Sprite2D

var dead = false
signal stop_bird
	
func _ready():
	ground.global_position.x = 72
	
func _process(delta):
	if not dead:
		sprite.global_position.x += speed * delta
		sprite2.global_position.x += speed * delta

	if sprite.global_position.x < -312:
		sprite.global_position.x = 24
		sprite2.global_position.x = 384


func _on_pipes_bird_touched():
	dead = true
	
	

func _on_ground_1_body_entered(body):
	dead = true
	stop_bird.emit()


func _on_ground_2_body_entered(body):
	dead = true
	stop_bird.emit()
