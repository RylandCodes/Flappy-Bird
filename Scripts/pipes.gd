extends Node2D

@onready var timer = $Timer
@onready var pipes = $Pipes
@onready var pipe_pair = $Pipes/PipePair

@export var speed = 450
var dead = false
var start = false

signal Bird_Touched
signal scored

@onready var coinsound = $coinsound

func _on_timer_timeout():
	make_pipe()
	
func _ready():
	pipe_pair.visible = false
	var score = pipe_pair.get_node("Score/CollisionShape2D")
	var top_pipe = pipe_pair.get_node("TopPipe/CollisionShape2D")
	var bottom_pipe = pipe_pair.get_node("BottomPipe/CollisionShape2D")
	score.disabled = true
	top_pipe.disabled = true
	bottom_pipe.disabled = true
	
func _physics_process(delta):
	if start:
		if not dead:
			var children = pipes.get_children()
			for pair in children:
				pair.global_position.x -= speed * delta
		else:
			var children = pipes.get_children()
			for pair in children:
				if pair.has_node("Timer"):
					timer = pair.get_node("Timer")
					timer.stop()		
func make_pipe():
	if not dead and start:
		var clone = pipe_pair.duplicate()
		var timer = clone.get_node("Timer") 
		
		clone.visible = true
		timer.autostart = true
		pipes.add_child(clone)  
		clone.name = "PipePair"
		var score = clone.get_node("Score/CollisionShape2D")
		var top_pipe = clone.get_node("TopPipe/CollisionShape2D")
		var bottom_pipe = clone.get_node("BottomPipe/CollisionShape2D")
		score.disabled = false
		top_pipe.disabled = false
		bottom_pipe.disabled = false
		clone.visible = true
		clone.global_position.x = 1000
		clone.global_position.y = randi_range(320, 990)
		


func _on_top_pipe_body_entered(body):
	if body.name == "Bird":
		Bird_Touched.emit()
		dead = true

func _on_bottom_pipe_body_entered(body):
	if body.name == "Bird":
		Bird_Touched.emit()
		dead = true


func _on_ground_stop_bird():
	Bird_Touched.emit()
	dead = true


func _on_bird_start():
	start = true
	


func _on_score_body_entered(body):
	scored.emit()
	coinsound.play()
